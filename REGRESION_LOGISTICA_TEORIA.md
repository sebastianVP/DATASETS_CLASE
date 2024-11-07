<img src="https://upload.wikimedia.org/wikipedia/commons/f/f7/Uni-logo_transparente_granate.png" alt= "LOGO CAT" width=400 height=400 align = "right">

<br>
<h1><font color="#7F000E" size=5> Maestria de Ciencias de la Computacion UNI</font></h1>

<h1><font color="#7F000R" size=6> Aprendizaje de Máquina para Visión Computacional </font></h1>
<h1><font color="#7F000E" size=4>Proyecto V:  REGRESION LOGISTICA</font></h1>
<br>
<br>
<div style="text-align:right">
<font color="#7F000E" size=3> Alumno:  Alexander O. Valdez Portocarrero</font><br>
<font color="#7F000E" size=3> Codigo: 20207072E </font><br>
<font color="#7F000e" size=3> Ciclo 2024-2 </font><br>
</div>


# 1. Función Sigmoide

En la regresión logística, usamos la función sigmoide para convertir una combinación lineal de las características en una probabilidad. La función sigmoide se define como:

 $`\sqrt{3x-1}+(1+x)^2`$


\[
\sigma(z) = \frac{1}{1 + e^{-z}
\]

donde:
- \( z = X \cdot \beta \): Es el producto de las características \( X \) y los coeficientes o pesos \( \beta \).
- El resultado de \( \sigma(z) \) es una probabilidad entre 0 y 1.

## 2. Función de Costo con Regularización Lasso para Regresión Logística

La función de costo para regresión logística con regularización Lasso (L1) se define como:

\[
J(\beta) = -\frac{1}{m} \sum_{i=1}^{m} \left[ y^{(i)} \cdot \log(\sigma(z^{(i)})) + (1 - y^{(i)}) \cdot \log(1 - \sigma(z^{(i)})) \right] + \lambda \sum_{j=1}^{n} |\beta_j|
\]

donde:
- \( m \) es el número de muestras en el conjunto de datos.
- \( y^{(i)} \) es el valor verdadero para la muestra \( i \)-ésima.
- \( \sigma(z^{(i)}) \) es la probabilidad predicha para la muestra \( i \)-ésima.
- \( \lambda \) es el parámetro de regularización (`lambda_reg` en el código). Un valor más alto de \( \lambda \) aplica una penalización más fuerte sobre los coeficientes, forzando a algunos a acercarse a cero.
- La **penalización Lasso** se aplica como \( \lambda \sum_{j=1}^{n} |\beta_j| \), lo que permite la **selección de características** al reducir algunos coeficientes a cero.

## 3. Gradiente de Lasso para Regresión Logística

Para optimizar la función de costo, calculamos el gradiente parcial respecto a cada \( \beta_j \):

\[
\frac{\partial J(\beta)}{\partial \beta_j} = \frac{1}{m} \sum_{i=1}^{m} ( \sigma(z^{(i)}) - y^{(i)}) \cdot x_j^{(i)} + \lambda \cdot \text{sign}(\beta_j)
\]

donde:
- \( \sigma(z^{(i)}) - y^{(i)} \) es el error entre la predicción y el valor real.
- \( x_j^{(i)} \) es el valor de la característica \( j \)-ésima para la muestra \( i \)-ésima.
- \( \text{sign}(\beta_j) \) es el signo de \( \beta_j \), que asegura la regularización Lasso (L1).

## 4. Descenso de Gradiente para Regresión Logística con Lasso

En el descenso de gradiente, actualizamos los coeficientes \( \beta \) en cada iteración usando la ecuación:

\[
\beta_j := \beta_j - \text{learning\_rate} \cdot \frac{\partial J(\beta)}{\partial \beta_j}
\]

donde:
- **`learning_rate`** es el tamaño de paso de cada actualización. Si es muy grande, el algoritmo podría no converger; si es muy pequeño, la convergencia podría ser muy lenta.
- **`lambda_reg`** controla la penalización sobre los coeficientes, lo que influye en la selección de características.



## Explicación de los Parámetros
- **`X`**: Matriz de características de entrenamiento.
- **`y`**: Vector de etiquetas de entrenamiento (0 o 1).
- **`beta_init`**: Vector inicial de coeficientes, que se actualizará durante el descenso de gradiente.
- **`learning_rate`**: Determina el tamaño de los pasos en cada iteración del descenso de gradiente.
- **`lambda_reg`**: Parámetro de regularización para controlar la penalización L1 (Lasso). Un valor alto de `lambda_reg` aplicará una mayor penalización, forzando algunos coeficientes a ser cero.
- **`num_iterations`**: Número de iteraciones del descenso de gradiente.

Este código optimiza los coeficientes `beta` para una regresión logística con regularización Lasso, aplicando la función de costo y gradiente definidas anteriormente.
