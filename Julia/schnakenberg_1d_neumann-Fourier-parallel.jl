# =========================
# 1D Schnakenberg reaction-diffusion model (最適化版)
# zero-flux (Neumann) boundary condition
# finite difference + explicit Euler
#
# ∂u/∂t = Du * u_xx + a - u + u^2 * v
# ∂v/∂t = alpha * ( Dv * v_xx + b - u^2 * v )
#
# 最適化のポイント:
#   1. In-place演算でメモリアロケーションを排除
#   2. コサイン基底を事前計算（ループ内で再計算しない）
#   3. @inboundsと@simdで演算ループを高速化
#   4. Threads.@threadsでDuパラメータスキャンを並列化
# =========================

# julia --threads 6 schnakenberg_1d_neumann-Fourier-parallel.jl

using Random
using Printf
using Statistics
using Profile
using Base.Threads

# ---- ラプラシアン（in-place版、配列確保なし） ----
function laplacian_neumann_1d!(L, A, dx)
    N = length(A)
    inv_dx2 = 1.0 / (dx * dx)
    @inbounds begin
        L[1] = (A[2] - A[1]) * inv_dx2
        @simd for i in 2:N-1
            L[i] = (A[i+1] - 2.0*A[i] + A[i-1]) * inv_dx2
        end
        L[N] = (A[N-1] - A[N]) * inv_dx2
    end
    return nothing
end

# ---- コサインモード係数（事前計算した基底を使用） ----
function cosine_mode_coefficients_precomputed(u, cosine_basis, dx, Lx)
    maxmode = size(cosine_basis, 1)
    coeffs = Vector{Float64}(undef, maxmode + 1)

    # mode 0
    coeffs[1] = dx * sum(u) / Lx

    # mode 1, 2, ...
    @inbounds for n in 1:maxmode
        s = 0.0
        basis = @view cosine_basis[n, :]
        @simd for i in eachindex(u)
            s += u[i] * basis[i]
        end
        coeffs[n+1] = 2.0 * dx * s / Lx
    end
    return coeffs
end

function run_single_du(Du, idx, total, x, dx, Lx, dt, nsteps, save_every,
                        Dv, alpha, a, b, u0, v0, cosine_basis)
    Nx = length(x)

    # 状態配列（in-place更新用）
    u     = fill(u0, Nx)
    v     = fill(v0, Nx)
    u_new = similar(u)
    v_new = similar(v)
    Lu    = similar(u)
    Lv    = similar(v)

    # 初期条件
    @inbounds for i in 1:Nx
        u[i] += 0.11   * cos(pi * x[i]) - 0.5  * cos(2*pi * x[i])
        v[i] += -0.01  * cos(pi * x[i]) + 0.05  * cos(2*pi * x[i])
    end

    @printf("Running Du = %f (%d / %d)\n", Du, idx, total)

    outfile = @sprintf("u_cosine_modes_Du_%.7f.dat", Du)

    coeffs = zeros(3)  # 最後の出力用

    open(outfile, "w") do io
        println(io, "t mode0 mode1 mode2")

        @inbounds for step in 1:nsteps
            # ラプラシアン（in-place）
            laplacian_neumann_1d!(Lu, u, dx)
            laplacian_neumann_1d!(Lv, v, dx)

            # オイラー更新（in-place、ブロードキャストなし）
            @simd for i in 1:Nx
                u2v       = u[i] * u[i] * v[i]
                u_new[i]  = u[i] + dt * (Du * Lu[i] + a - u[i] + u2v)
                v_new[i]  = v[i] + dt * alpha * (Dv * Lv[i] + b - u2v)
            end

            # 結果をコピー（u_new → u）
            copyto!(u, u_new)
            copyto!(v, v_new)

            if step % save_every == 0
                t = dt * step
                coeffs = cosine_mode_coefficients_precomputed(u, cosine_basis, dx, Lx)
                @printf(io, "%.8f %.12e %.12e %.12e\n",
                        t, coeffs[1], coeffs[2], coeffs[3])

                if step % (save_every * 100) == 0
                    @printf("  t = %.8f, mode0 = %.10e, mode1 = %.10e, mode2 = %.10e\n",
                            t, coeffs[1], coeffs[2], coeffs[3])
                end
            end
        end
    end

    println("  saved: " * outfile)
end

function main()
    Nx = 200
    Lx = 1.0
    T  = 30000.0
    dx = Lx / Nx

    Dv    = 0.300
    alpha = 0.63
    a     = 0.1
    b     = 1.0

    dt         = dx^2 / 5.0
    nsteps     = round(Int, T / dt)
    save_every = 20000

    Du_values = collect(0.014073:0.0000001:0.014073)

    Random.seed!(1234)

    xb = range(0.0, Lx, length=Nx+1)
    x  = collect(xb[1:Nx] .+ dx/2)

    u0 = a + b
    v0 = b / (a + b)^2

    # コサイン基底を事前計算（毎ステップ再計算しない）
    maxmode      = 2
    cosine_basis = Matrix{Float64}(undef, maxmode, Nx)
    for n in 1:maxmode
        for i in 1:Nx
            cosine_basis[n, i] = cos(n * pi * x[i] / Lx)
        end
    end

    println("Start parameter scan")
    @printf("Nx = %d, dt = %.8f, nsteps = %d, save_every = %d\n",
            Nx, dt, nsteps, save_every)
    @printf("Threads available: %d\n", Threads.nthreads())

    # Duのスキャンをスレッド並列化
    # 注意: 各Duが独立しているため安全に並列化できる
    # ただし出力ファイルが混在しないよう各スレッドが別ファイルに書く
    Threads.@threads for idx in 1:length(Du_values)
        Du = Du_values[idx]
        run_single_du(Du, idx, length(Du_values), x, dx, Lx, dt, nsteps,
                      save_every, Dv, alpha, a, b, u0, v0, cosine_basis)
    end

    println("\nSimulation finished.")
end

main()
#@time main()
