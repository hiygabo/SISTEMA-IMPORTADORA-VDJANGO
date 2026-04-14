-- 1. CREACIÓN DE TABLAS
CREATE TABLE categoria(
    id_categoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100)
);

CREATE TABLE usuario(
    id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100),
    rol VARCHAR2(100)
);

CREATE TABLE producto(
    id_producto NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100),
    precio NUMBER(10,2),
    stock NUMBER(5),
    id_categoria NUMBER REFERENCES categoria(id_categoria)
);

CREATE TABLE pedido(
    id_pedido NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    fecha DATE,
    estado VARCHAR2(20),
    id_trabajador NUMBER REFERENCES usuario(id_usuario)
);

CREATE TABLE detalle_pedido(
    id_pedido NUMBER REFERENCES pedido(id_pedido),
    id_producto NUMBER REFERENCES producto(id_producto),
    cantidad NUMBER(5),
    subtotal NUMBER(10,2),
    PRIMARY KEY(id_pedido, id_producto)
);

-- 2. ALTERACIÓN DE TABLA PARA LOGIN MANUAL
ALTER TABLE usuario ADD contrasena varchar2(255);

-- 3. INSERCIÓN DE CATEGORÍAS
INSERT INTO categoria (nombre) VALUES ('Periféricos y Accesorios'); 
INSERT INTO categoria (nombre) VALUES ('Monitores y Electrónica');
INSERT INTO categoria (nombre) VALUES ('Mobiliario y Hogar');

-- 4. INSERCIÓN DE PRODUCTOS
-- [Categoría 1: Periféricos y Accesorios]
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Mouse Inalámbrico Recargable RGB', 45.50, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Mouse Gamer X-Pro Ergonomico', 120.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Teclado Mecánico Mini 60% Switch Blue', 210.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Teclado Membrana Iluminado', 85.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Cable USB-C de Nylon Reforzado 2m', 25.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Cable Magnético 3 en 1 Carga Rápida', 35.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Cargador Pared Carga Rápida 20W', 65.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Cargador Inalámbrico Fast Charge', 90.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Hub USB 3.0 de 4 Puertos Aluminio', 55.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Adaptador Bluetooth 5.0 USB', 30.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Audífonos Inalámbricos TWS F9', 75.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Audífonos Gamer con Micrófono y Luz', 150.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Funda Sumergible para Celular', 15.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Soporte Magnético Celular para Auto', 40.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Mando Bluetooth para Celular/PC', 110.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Batería Externa PowerBank 10000mAh', 130.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Batería Externa Solar 20000mAh', 190.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Adaptador Tipo C a HDMI/USB', 145.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Lápiz Táctil Universal Stylus', 35.00, 1);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Mousepad Extra Grande 80x30cm', 60.00, 1);

-- [Categoría 2: Monitores y Electrónica Mayor]
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Smartwatch Serie 8 Clon', 180.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Banda Deportiva Inteligente M6', 50.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Mini Proyector LED Portátil WiFi', 450.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Cámara de Seguridad WiFi 360 Exterior', 220.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Cámara Web 1080p con Micrófono', 130.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Parlante Bluetooth Portátil Waterproof', 115.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Barra de Sonido para TV/PC', 250.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Caja Convertidora Smart TV Box Android', 280.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Micrófono Condensador USB Studio', 195.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Capturadora de Video USB HDMI', 95.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Monitor Portátil 15.6" IPS Type-C', 950.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Gafas de Realidad Virtual para Celular', 85.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Repetidor Amplificador Señal WiFi', 120.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Control Remoto Universal Infrarrojo', 65.00, 2);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Kit Sistema de Alarma Smart Home', 350.00, 2);

-- [Categoría 3: Mobiliario, Gadgets de Hogar y Varios]
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Humidificador Difusor de Aromas Madera', 80.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Lámpara de Escritorio LED Flexible', 55.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Tira LED RGB 5 Metros con Control', 65.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Aro de Luz LED 10" con Trípode', 140.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Aspiradora Robot Trapeadora Inteligente', 650.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Termo Digital con Pantalla LED', 45.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Báscula Digital de Cocina 10kg', 35.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Báscula Corporal Inteligente Bluetooth', 110.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Masajeador Muscular Pistola', 180.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Masajeador de Cuello Cervical', 75.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Soporte Ergonómico Plegable para Laptop', 60.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Kit Destornilladores de Precisión 115 en 1', 90.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Mochila Antirrobo con Puerto USB', 130.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Silla Gamer Económica Reclinable', 650.00, 3);
INSERT INTO producto (nombre, precio, id_categoria) VALUES ('Escritorio Plegable para Laptop Cama', 70.00, 3);

-- 5. ACTUALIZACIÓN DE USUARIOS EXISTENTES
-- (Si se requiere crear a los usuarios desde cero, insertar primero y luego actualizar; aquí actualizamos los IDs preexistentes)
UPDATE usuario SET contrasena = 'trabGOA2026' WHERE id_usuario = 1;
UPDATE usuario SET contrasena = 'trabJUAP2026' WHERE id_usuario = 2;
UPDATE usuario SET contrasena = 'trabLMAR2026' WHERE id_usuario = 21;
UPDATE usuario SET contrasena = 'trabSOFC2026' WHERE id_usuario = 22;
UPDATE usuario SET contrasena = 'cajMARL2026' WHERE id_usuario = 23;
UPDATE usuario SET contrasena = 'trabJORT2026' WHERE id_usuario = 24;
UPDATE usuario SET contrasena = 'admADMN2026' WHERE id_usuario = 25;

UPDATE usuario SET nombre = 'Gabriel Andia' WHERE ID_USUARIO = 1;
UPDATE usuario SET nombre = 'Juan Peredo' WHERE ID_USUARIO = 2;

COMMIT;