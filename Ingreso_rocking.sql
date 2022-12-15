CREATE TABLE empleados
    ([id] int, [nombre] nvarchar(30), [id_lider] int, [lider] nvarchar(30), [area] nvarchar(30), [fecha] date, [activo] nvarchar(2))
;

INSERT INTO empleados
    ([id] , [nombre], [id_lider], [lider], [area], [fecha], [activo])
VALUES
(1,	'fred',	null,	null,	'direccion general',	'2021-01-31',	'si'),
(1,	'fred',	null,	null,	'direccion general',	'2021-02-28',	'si'),
(1,	'fred',	null,	null,	'direccion general',	'2021-03-31',	'si'),
(1, 'fred',	null,	null,	'direccion general',	'2021-04-30',	'si'),
(2,	'asistente',	1,	'fred',	'direccion general',	'2021-01-31',	'si'),
(2,	'asistente',	1,	'fred',	'direccion general',	'2021-02-28',	'si'),
(2,	'asistente',	1,	'fred',	'direccion general',	'2021-03-31',	'no'),
(2,	'asistente',	1,	'fred',	'direccion general',	'2021-04-30',	'no'),
(3,	'mafi',	1,	'fred',	'direccion analytics',	'2021-01-31',	'si'),
(3,	'mafi',	1,	'fred',	'direccion analytics',	'2021-02-28',	'si'),
(	3,	'mafi',	1,	'fred',	'direccion analytics',	'2021-03-31',	'si'),
(	3,	'mafi',	1,	'fred',	'direccion analytics',	'2021-04-30',	'si'),
(	4,	'jefa',	3,	'mafi',	'direccion analytics',	'2021-01-31',	'si'),
(	4,	'jefa',	3,	'mafi',	'direccion analytics',	'2021-02-28',	'si'),
(	4,	'jefa',	3,	'mafi',	'direccion analytics',	'2021-03-31',	'no'),
(	4,	'jefa',	3,	'mafi',	'direccion analytics',	'2021-04-30',	'no'),
(	5,	'tomy',	4,	'jefa',	'direccion analytics',	'2021-01-31',	'si'),
(	5,	'tomy',	4,	'jefa',	'direccion analytics',	'2021-02-28',	'si'),
(	5,	'tomy',	4,	'jefa',	'direccion analytics',	'2021-03-31',	'si'),
(	5,	'tomy',	3,	'mafi',	'direccion analytics',	'2021-04-30',	'si'),
(	6,	'cordi',	1,	'fred',	'data engineer',	'2021-01-31',	'si'),
(	6,	'cordi',	1,	'fred',	'data engineer',	'2021-02-28',	'si'),
(	6,	'cordi',	1,	'fred',	'data engineer',	'2021-03-31',	'si'),
(	6,	'cordi',	1,	'fred',	'data engineer',	'2021-04-30',	'si'),
(	7,	'pasante datos',	6,	'cordi',	'data engineer',	'2021-03-31',	'si'),
(	7,	'pasante datos',	6,	'cordi',	'data engineer',	'2021-04-30',	'no'),
(	8,	'guilla',	6,	'cordi',	'data engineer',	'2021-03-31',	'si'),
(	8,	'guilla',	6,	'cordi',	'data engineer',	'2021-04-30',	'si')
;

WITH RecursiveCTE AS
(
    SELECT
        id = E.id,
        nombre = E.nombre,
        id_lider = NULL,
        niveles = 1,
        secuencia = CONVERT(VARCHAR(MAX), E.nombre)
    FROM
        empleados AS E
    WHERE
        E.id_lider IS NULL

    UNION ALL

    SELECT
        id = E.id,
        nombre = E.nombre,
        id_lider = E.id_lider,
        niveles = R.niveles + 1,
        secuencia = R.secuencia + '|' + CONVERT(VARCHAR(10), E.nombre)
    FROM
        RecursiveCTE AS R
        INNER JOIN empleados AS E ON R.id = E.id_lider
)
SELECT
    R.nombre,
    R.secuencia
FROM
    RecursiveCTE AS R
ORDER BY
    R.niveles,
    R.id

