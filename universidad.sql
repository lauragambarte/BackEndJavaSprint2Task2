-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT  apellido1, apellido2,nombre
FROM persona
WHERE tipo="alumno"
ORDER BY apellido1, apellido2,nombre ASC

-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo="alumno" AND telefono IS NULL

-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT *
FROM persona
WHERE tipo="alumno" AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31'

-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT *
FROM persona
WHERE tipo="profesor" AND nif LIKE '%K'

-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT *
FROM asignatura
WHERE curso=3 AND id_grado=7

-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

SELECT apellido1, apellido2, persona.nombre, departamento.nombre AS departamento
FROM persona
INNER JOIN profesor
ON persona.id=profesor.id_profesor
INNER JOIN departamento
ON profesor.id_departamento=departamento.id
WHERE persona.tipo='profesor'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC

-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asig.nombre, ce.anyo_inicio AS año_inicio, ce.anyo_fin AS año_fin
FROM asignatura asig
INNER JOIN alumno_se_matricula_asignatura alu_asig
ON asig.id=alu_asig.id_asignatura
INNER JOIN curso_escolar ce
ON ce.id=alu_asig.id_curso_escolar
WHERE id_alumno IN(
SELECT id
FROM persona
WHERE nif="26902806M"
)
-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT depto.nombre
FROM departamento depto
INNER JOIN profesor prof
ON depto.id=prof.id_departamento
INNER JOIN asignatura asig
ON asig.id_profesor=prof.id_profesor
WHERE id_grado IN(
SELECT id
FROM grado
WHERE nombre="Grado en Ingeniería Informática (Plan 2015)"
)

-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.

SELECT DISTINCT persona.nombre,persona.apellido1, persona.apellido2
FROM persona
INNER JOIN alumno_se_matricula_asignatura alu_asig
ON persona.id=alu_asig.id_alumno
INNER JOIN curso_escolar ce
ON ce.id=alu_asig.id_curso_escolar 
WHERE anyo_inicio="2018" and anyo_fin="2019"

/* ANOTHER WAY TO RUN SAME QUERY WITH SUBQUERY
SELECT DISTINCT persona.nombre,persona.apellido1, persona.apellido2
FROM persona
INNER JOIN alumno_se_matricula_asignatura alu_asig
ON persona.id=alu_asig.id_alumno
WHERE alu_asig.id_curso_escolar IN (
SELECT id
FROM curso_escolar
WHERE anyo_inicio="2018" and anyo_fin="2019"
)
*/

-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre
FROM profesor
LEFT JOIN persona
ON profesor.id_profesor=persona.id
LEFT JOIN departamento
ON profesor.id_departamento=departamento.id
ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre ASC

-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT persona.nombre,persona.apellido1, persona.apellido2
FROM profesor
LEFT JOIN persona
ON profesor.id_profesor=persona.id
LEFT JOIN departamento
ON profesor.id_departamento=departamento.id
WHERE profesor.id_departamento IS NULL

-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre
FROM profesor
RIGHT JOIN departamento
ON departamento.id=profesor.id_departamento
WHERE profesor.id_profesor IS NULL

-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT persona.nombre,persona.apellido1, persona.apellido2
FROM profesor
LEFT JOIN persona
ON profesor.id_profesor=persona.id
LEFT JOIN asignatura asig
ON profesor.id_profesor=asig.id_profesor
WHERE asig.id_profesor IS NULL

-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

SELECT asig.nombre
FROM asignatura asig
WHERE asig.id_profesor IS NULL

-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

SELECT dpto.id, dpto.nombre
FROM departamento dpto
LEFT JOIN profesor
ON dpto.id=profesor.id_departamento
LEFT JOIN asignatura asig
ON profesor.id_profesor=asig.id_profesor
LEFT JOIN alumno_se_matricula_asignatura alu_asig
ON asig.id=alu_asig.id_asignatura
GROUP BY dpto.id
HAVING COUNT(id_curso_escolar)=0


-- Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*)
FROM persona
WHERE tipo="alumno"


-- Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*)
FROM persona
WHERE tipo="alumno" AND fecha_nacimiento LIKE '1999%'
-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es. 
SELECT departamento.nombre, COUNT(*) as numero_profesores
FROM departamento
INNER JOIN profesor
ON departamento.id=profesor.id_departamento
GROUP BY departamento.id
ORDER BY 2 DESC
--take column number 2 to order from the result of the group by(entire query with SELECT departamento.nombre...)

-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre, COUNT(profesor.id_profesor) as numero_profesores
FROM departamento
LEFT JOIN profesor
ON departamento.id=profesor.id_departamento
GROUP BY departamento.id
-- changing the count to COUNT(profesor.id_profesor) because COUNT (*) counts the number of lines.

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

SELECT grado.nombre, COUNT(asignatura.id) as numero_asignaturas
FROM grado
LEFT JOIN asignatura
ON grado.id=asignatura.id_grado
GROUP BY grado.id
ORDER BY 2 DESC

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id) as numero_asignaturas
FROM grado
LEFT JOIN asignatura
ON grado.id=asignatura.id_grado
GROUP BY grado.id
HAVING numero_asignaturas > 40
ORDER BY 2 DESC

-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

SELECT grado.nombre, asignatura.tipo, sum(asignatura.creditos) as total_creditos
FROM grado
INNER JOIN asignatura
ON grado.id=asignatura.id_grado
GROUP BY grado.id, asignatura.tipo

-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

SELECT ce.anyo_inicio, COUNT(DISTINCT id_alumno) as numero_alumnos_matriculados
FROM curso_escolar ce 
LEFT JOIN alumno_se_matricula_asignatura alu_asig
ON ce.id=alu_asig.id_curso_escolar
GROUP BY ce.anyo_inicio

-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT prof.id_profesor, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asig.id) as numero_asignaturas
FROM profesor prof
LEFT JOIN persona
ON prof.id_profesor=persona.id
LEFT JOIN asignatura asig
ON prof.id_profesor=asig.id_profesor
GROUP BY id_profesor
ORDER BY 5 DESC
 -- Retorna totes les dades de l'alumne/a més jove.
 
 SELECT *
 FROM persona
 WHERE persona.tipo="alumno" 
 ORDER BY fecha_nacimiento DESC
 LIMIT 1
 
 -- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
 
 SELECT persona.nombre, persona.apellido1,persona.apellido2
 FROM profesor prof
LEFT JOIN persona
ON prof.id_profesor=persona.id
LEFT JOIN asignatura asig
ON prof.id_profesor=asig.id_profesor
WHERE asig.id IS NULL