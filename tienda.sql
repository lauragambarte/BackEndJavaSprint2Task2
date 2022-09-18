-- Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre
FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio
FROM producto;

-- Llista totes les columnes de la taula producto.
SHOW columns
FROM producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT *, ROUND(precio/0.98,2) AS precio_USD
FROM producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS nom_de_producto, precio AS euros, ROUND(precio/0.98,2) AS dolars
FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre) AS nombre_mayus, precio
FROM producto;

-- lista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre_minus, precio
FROM producto;

-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(SUBSTRING(nombre,1,2)) AS first_two_letters
FROM fabricante;

-- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre,ROUND(precio,0)
FROM producto
-- TRUNCATE CUTS OFF THE DECIMALS NOT ROUNDING. FOR EX: 149,99 will be truncated to 149.
-- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre,TRUNCATE(precio,0)
FROM producto;

-- Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo_fabricante
FROM producto;

-- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo_fabricante
FROM producto;

-- Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

-- Llista els noms dels fabricants ordenats de manera descendent
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;
-- THIS ONLY MAKES SENSE WHEN THERE ARE TWO FABRICANTES WITH THE SAME NAME, THEN WOULD SORT PRICE IN DESC ORDER.
-- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

-- Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT *
FROM fabricante
LIMIT 5;

-- You can use LIMIT 2,1 instead of WHERE row_number() = 3.
-- As the documentation explains, the first argument specifies the offset of the first row to return, and the second specifies the maximum number of rows to return.
-- Keep in mind that it's an 0-based index. So, if you want the line number n, the first argument should be n-1. The second argument will always be 1, because you just want one row. For example, if you want the line number 56 of a table customer:

-- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT *
FROM fabricante
LIMIT 3,2;

-- Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre,precio
FROM producto
ORDER BY precio ASC
LIMIT 1

-- Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUPBY

SELECT nombre,precio
FROM producto
ORDER BY precio DESC
LIMIT 1

-- Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre
FROM fabricante
WHERE codigo=2


-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre AS producto_nombre,precio, f.nombre AS fabricante_nombre
FROM producto p
LEFT JOIN fabricante f
ON p.codigo_fabricante=f.codigo

-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre AS producto_nombre,precio, f.nombre AS fabricante_nombre
FROM producto p
LEFT JOIN fabricante f
ON p.codigo_fabricante=f.codigo
ORDER BY f.nombre ASC;

-- Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.

SELECT p.codigo AS producto_codigo, p.nombre AS producto_nombre, f.codigo AS fabricante_codigo, f.nombre AS fabricante_nombre
FROM producto p
LEFT JOIN fabricante f
ON p.codigo_fabricante=f.codigo

-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.

SELECT p.nombre AS producto_nombre, precio,f.nombre AS fabricante_nombre
FROM producto p
LEFT JOIN fabricante f
ON p.codigo_fabricante=f.codigo
ORDER BY precio ASC
LIMIT 1

-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.

SELECT  p.nombre AS producto_nombre, precio,f.nombre AS fabricante_nombre
FROM producto p
LEFT JOIN fabricante f
ON p.codigo_fabricante=f.codigo
ORDER BY precio DESC
LIMIT 1

-- Retorna una llista de tots els productes del fabricant Lenovo.
SELECT  f.nombre AS fabricante_nombre, p.nombre AS producto_nombre
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
WHERE f.nombre='Lenovo'

-- Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.

SELECT  f.nombre AS fabricante_nombre, p.nombre AS producto_nombre
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
WHERE f.nombre='Crucial' and p.precio>200

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
SELECT  f.nombre AS fabricante_nombre, p.nombre AS producto_nombre
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
WHERE f.nombre ='Crucial' OR f.nombre='Hewlett-Packard' OR f.nombre='Seagate';

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
SELECT  f.nombre AS fabricante_nombre, p.nombre AS producto_nombre
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
WHERE f.nombre in ('Crucial','Hewlett-Packard','Seagate');

-- Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT p.nombre AS producto_nombre,p.precio
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
WHERE f.nombre LIKE '%e'

-- Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre AS producto_nombre,p.precio
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
WHERE f.nombre LIKE '%w%'

-- Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).

SELECT p.nombre, p.precio, f.nombre
FROM producto p
LEFT JOIN fabricante f
ON p.codigo_fabricante=f.codigo
WHERE p.precio>=180
ORDER BY p.precio DESC,p.nombre ASC;

-- Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.

SELECT f.codigo, f.nombre
FROM fabricante f
INNER JOIN producto p
ON p.codigo_fabricante=f.codigo

-- Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats

SELECT f.nombre
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante=f.codigo
GROUP BY f.nombre

-- Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.

SELECT f.nombre, f.codigo
FROM fabricante f
WHERE f.codigo NOT IN (
    SELECT codigo_fabricante
    FROM producto
)
-- Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).

SELECT p.nombre, p.codigo
FROM producto p
WHERE p.codigo_fabricante  IN (
    SELECT codigo
    FROM fabricante
    WHERE fabricante.nombre="Lenovo"
)
-- Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).

SELECT *
FROM producto p
WHERE p.precio IN (
    SELECT MAX(precio)
    FROM producto p
    WHERE p.codigo_fabricante  IN (
    SELECT codigo
    FROM fabricante
    WHERE fabricante.nombre="Lenovo"
    )
)
-- Llista el nom del producte més car del fabricant Lenovo.
SELECT p.nombre
FROM producto p
WHERE p.codigo_fabricante  IN (
    SELECT codigo
    FROM fabricante
    WHERE fabricante.nombre="Lenovo")
    ORDER BY p.precio DESC
    LIMIT 1

-- Llista el nom del producte més barat del fabricant Hewlett-Packard.

SELECT p.nombre
FROM producto p
WHERE p.codigo_fabricante  IN (
    SELECT codigo
    FROM fabricante
    WHERE fabricante.nombre="Hewlett-Packard")
ORDER BY p.precio ASC
LIMIT 1


-- Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.

SELECT *
FROM producto p
WHERE p.precio >= (
    SELECT MAX(precio)
    FROM producto p
    WHERE p.codigo_fabricante  IN (
		SELECT codigo
		FROM fabricante
		WHERE fabricante.nombre="Lenovo"
	)
)


-- Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.

SELECT *
FROM producto p
WHERE p.precio >= (
    SELECT AVG(precio)
    FROM producto p
    WHERE p.codigo_fabricante  IN (
		SELECT codigo
		FROM fabricante
		WHERE fabricante.nombre="Asus"
	)
) AND  p.codigo_fabricante  IN (
		SELECT codigo
		FROM fabricante
		WHERE fabricante.nombre="Asus"
        )