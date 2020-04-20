        real function fun(x)
                real x
                fun = sqrt(1 + x**5)
                return
        end

        real function f_z(z)
                real z
                f_z = 2*z*(1-0.7**z)+0.49**z+(z-1)**2
                return
        end

        external fun
        external f_z
        integer            :: nofun
        integer, parameter :: N = 7, out=0
        real res, fmin, fun, f_z
        REAL A,B,ABSERR,RELERR,ERREST,FLAG, tol, minimum
        real Q, R
        A = 0
        B = 0.5d0
        RELERR = 1.e-06
        ABSERR = 1.e-06

        !Finding integral f(x)dx
        write(*,*) "################"
        write(*,*) "f(x)=sqrt(1 + x^5)"
        write(*,*) "Integrating from 0 to 0.5 f(x)dx"

        call quanc8(fun,a,b,ABSERR,RELERR,RES,ERREST,nofun,FLAG)

        write(*,"(' integral f(x)=', f15.10)") res
        !Finding minimum of a fuction on interval
        write(*,*) "################"

        write(*,*) "f(z) = 2*z*(1-0.7**z)+0.49**z+(z-1)**2"
        write(*,*) "Finding minimum of f(z) over [0.1, 1.0]"       
        TOL = 1.0E-06
        A = 0.1d0
        B = 1.0d0
        minimum = FMIN(A,B,f_z,tol)
        write(*,"(' Min f(z)= ',f7.5)") minimum

        !finding Q and R
        write(*,*) "################"

        Q = (res - 0.5012966)**4
        write(*,"(' Q = ', f15.10)") Q

        R = 1.312255*minimum
        write(*,"(' R = ',f15.10)") R

        stop

        end
