CREATE DATABASE ventas_cava_dorada;
USE ventas_cava_dorada;
GO

/*
ANÁLISIS DE VENTAS - CAVA DORADA
Consultas SQL utilizadas como soporte del análisis exploratorio
desarrollado en Python y SQL Server.
*/

/* 1. Total de registros y transacciones */
SELECT COUNT(*) AS registros_totales, COUNT(DISTINCT id_venta) 
AS transacciones_unicas
FROM tabla_general_ventas;


/* 2. Ventas totales generales */
SELECT SUM(venta_total) AS ingresos_totales
FROM tabla_general_ventas;


/* 3. Ventas totales por categoría */
SELECT categoria, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY categoria
ORDER BY venta_total DESC;


/* 4. Top 5 categorías con mayores ventas */
SELECT TOP 5categoria,SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY categoria
ORDER BY venta_total DESC;


/* 5. Top 5 categorías con menores ventas */
SELECT TOP 5 categoria, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY categoria
ORDER BY venta_total ASC;


/* 6. Top 5 productos con mayores ventas */
SELECT TOP 5producto, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY producto
ORDER BY venta_total DESC;


/* 7. Productos con mayor cantidad vendida */
SELECT TOP 10 producto, SUM(cantidad) AS unidades_vendidas, SUM(venta_total) 
AS venta_total
FROM tabla_general_ventas
GROUP BY producto
ORDER BY unidades_vendidas DESC;


/* 8. Ventas totales por día de la semana */
SELECT dia, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY dia
ORDER BY venta_total DESC;


/* 9. Ventas totales por mes */
SELECT  mes, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY mes
ORDER BY venta_total DESC;


/* 10. Ticket promedio mensual */
SELECT mes, COUNT(DISTINCT id_venta) AS transacciones, SUM(venta_total)
AS venta_total, SUM(venta_total) * 1.0 / COUNT(DISTINCT id_venta) AS ticket_promedio
FROM tabla_general_ventas
GROUP BY mes
ORDER BY ticket_promedio DESC;


/* 11. Categorías con mayor número de transacciones */
SELECT categoria, COUNT(DISTINCT id_venta) AS transacciones
FROM tabla_general_ventas
GROUP BY categoria
ORDER BY transacciones DESC;


/* 12. Ventas por mes y día */
SELECT mes, dia, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY mes, dia
ORDER BY mes, dia;


/* 13. Verificar si existe venta en Abril - martes */
SELECT mes, dia, SUM(venta_total) AS venta_total
FROM tabla_general_ventas
WHERE mes = 'Abril' AND dia = 'martes'
GROUP BY mes, dia;


/* 14. Top 5 transacciones con mayor gasto */
SELECT TOP 5id_venta, SUM(venta_total) AS total_transaccion, SUM(cantidad)
AS cantidad_total
FROM tabla_general_ventas
GROUP BY id_venta
ORDER BY total_transaccion DESC;


/* 15. Ventas por categoría de precio y día -- Logica de python usando binning
a sql server con las categorias de precios
SELECT
    categoria_precio,
    dia,
    SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY categoria_precio, dia
ORDER BY categoria_precio, dia;
*/

/* 16. Ticket promedio por categoría */
SELECT categoria, COUNT(DISTINCT id_venta) AS transacciones, SUM(venta_total) 
AS venta_total, SUM(venta_total) * 1.0 / COUNT(DISTINCT id_venta) AS ticket_promedio
FROM tabla_general_ventas
GROUP BY categoria
ORDER BY ticket_promedio DESC;


/* 17. Análisis transaccional: cantidad total vs venta total */
SELECT id_venta, SUM(cantidad) AS cantidad_total, AVG(precio_uni) 
AS precio_promedio,SUM(venta_total) AS venta_total
FROM tabla_general_ventas
GROUP BY id_venta
ORDER BY venta_total DESC;
