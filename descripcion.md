
# 1. Función Sigmoide

En la regresión logística, usamos la función sigmoide para convertir una combinación lineal de las características en una probabilidad. La función sigmoide se define como:

\[
\sigma(z) = \frac{1}{1 + e^{-z}}
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

## Implementación en Python

Aquí tienes una implementación en Python del descenso de gradiente para regresión logística con regularización Lasso:

```python
import numpy as np

# Función sigmoide
def sigmoid(z):
    return 1 / (1 + np.exp(-z))

# Función de costo con regularización Lasso (L1)
def lasso_logistic_cost(X, y, beta, lambda_reg):
    m = len(y)
    z = X.dot(beta)
    predictions = sigmoid(z)
    cost = (-1 / m) * np.sum(y * np.log(predictions) + (1 - y) * np.log(1 - predictions))
    # Agregar penalización L1
    cost += lambda_reg * np.sum(np.abs(beta))
    return cost

# Gradiente para Lasso en regresión logística
def lasso_logistic_gradient(X, y, beta, lambda_reg):
    m = len(y)
    z = X.dot(beta)
    predictions = sigmoid(z)
    gradient = (1 / m) * X.T.dot(predictions - y)
    # Agregar derivada de la penalización L1
    gradient += lambda_reg * np.sign(beta)
    return gradient

# Descenso de gradiente para regresión logística con regularización Lasso
def lasso_logistic_gradient_descent(X, y, beta_init, learning_rate, lambda_reg, num_iterations):
    beta = beta_init
    cost_history = []
    
    for _ in range(num_iterations):
        gradient = lasso_logistic_gradient(X, y, beta, lambda_reg)
        beta = beta - learning_rate * gradient
        cost = lasso_logistic_cost(X, y, beta, lambda_reg)
        cost_history.append(cost)
    
    return beta, cost_history

# Ejemplo de uso
# Supongamos que tenemos datos X (muestras, características) y etiquetas y
np.random.seed(42)
X = np.random.rand(100, 3)  # 100 muestras, 3 características
y = np.random.randint(0, 2, 100)  # Valores binarios

# Inicialización
beta_init = np.zeros(X.shape[1])
learning_rate = 0.1
lambda_reg = 0.1  # Regularización L1
num_iterations = 1000

# Entrenamiento del modelo
beta_optimal, cost_history = lasso_logistic_gradient_descent(X, y, beta_init, learning_rate, lambda_reg, num_iterations)

# Resultados
print(f"Coeficientes optimizados: {beta_optimal}")
```

## Explicación de los Parámetros
- **`X`**: Matriz de características de entrenamiento.
- **`y`**: Vector de etiquetas de entrenamiento (0 o 1).
- **`beta_init`**: Vector inicial de coeficientes, que se actualizará durante el descenso de gradiente.
- **`learning_rate`**: Determina el tamaño de los pasos en cada iteración del descenso de gradiente.
- **`lambda_reg`**: Parámetro de regularización para controlar la penalización L1 (Lasso). Un valor alto de `lambda_reg` aplicará una mayor penalización, forzando algunos coeficientes a ser cero.
- **`num_iterations`**: Número de iteraciones del descenso de gradiente.

Este código optimiza los coeficientes `beta` para una regresión logística con regularización Lasso, aplicando la función de costo y gradiente definidas anteriormente.
