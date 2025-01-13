# Controller Parametrization Using Euclid's Algorithm

## Overview
This repository contains MATLAB code for the parametrization of controllers using Euclid's algorithm and coprime factorization. The primary objective is to design controllers that ensure internal stability for linear control systems and provide additional desired properties, such as tracking a reference signal. The method is based on mathematical formulations and the practical application of Euclid's algorithm.

---

## Theoretical Background
### 1. **Problem Formulation**
The unity-feedback system is considered, where:
- \( P(s) \): Plant transfer function (strictly proper).
- \( C(s) \): Controller transfer function (proper).

**Objective:**
1. Ensure internal stability of the closed-loop system.
2. Achieve an additional design criterion, e.g., step tracking.

### 2. **Parametrization Method**
The solution is based on the following steps:
- Coprime factorization: Factorize the plant \( P(s) \) as \( P(s) = rac{n(s)}{m(s)} \), where \( n(s) \) and \( m(s) \) are coprime polynomials.
- Use Euclid’s algorithm to compute the polynomials \( x(s) \) and \( y(s) \) that satisfy:

\[
 n(s)x(s) + m(s)y(s) = 1.
\]

This equation ensures the controller \( C(s) \) can be parametrized as:

\[
 C(s) = \frac{v(s)x(s) + u(s)m(s)}{v(s)n(s) + u(s)y(s)},
\]

where \( v(s) \) and \( u(s) \) are free design parameters.

---

## MATLAB Implementation
The provided MATLAB code performs the following:
1. **Check Stability:**
   - Determine the poles of the plant \( P(s) \) by finding the roots of its denominator.
   - If all poles have negative real parts, the plant is stable, and the algorithm ends.
   - If unstable, the algorithm proceeds to variable substitution.

2. **Variable Substitution:**
   - Transform \( s \) to \( x \) using \( s = \frac{1-x}{x} \) to analyze the plant in a different domain.

3. **Euclid’s Algorithm:**
   - Iteratively compute the quotient (\( q \)) and remainder (\( r \)) polynomials.
   - Stop when the remainder reduces to a polynomial of degree one.

4. **Controller Parametrization:**
   - Compute the matrices \( Q \) and \( R \) to determine the coefficients \( X(s) \) and \( Y(s) \).
   - Transform results back to the original variable \( s \).


## Notes (Persian)
این مخزن شامل کد متلب برای پارامتری‌سازی کنترلر با استفاده از الگوریتم اقلیدسی است. هدف طراحی کنترلرهایی است که پایداری داخلی سیستم را تضمین کنند. استفاده از این ابزار برای طراحی سیستم‌های کنترلی و شناسایی ضرایب بهینه بسیار مفید است.

---

## License
This project is licensed under the MIT License.

