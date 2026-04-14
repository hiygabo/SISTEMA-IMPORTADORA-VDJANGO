# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Categoria(models.Model):
    id_categoria = models.FloatField(primary_key=True)
    nombre = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'categoria'
        
    def __str__(self):
        return self.nombre


class DetallePedido(models.Model):
    pk = models.CompositePrimaryKey('id_pedido', 'id_producto')
    id_pedido = models.ForeignKey('Pedido', models.DO_NOTHING, db_column='id_pedido')
    id_producto = models.ForeignKey('Producto', models.DO_NOTHING, db_column='id_producto')
    cantidad = models.IntegerField(blank=True, null=True)
    subtotal = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'detalle_pedido'


class Pedido(models.Model):
    id_pedido = models.AutoField(primary_key=True)
    nombre_cliente = models.CharField(max_length=100, blank=True, null=True)
    fecha = models.DateField(blank=True, null=True)
    estado = models.CharField(max_length=20, blank=True, null=True)
    id_trabajador = models.ForeignKey('Usuario', models.DO_NOTHING, db_column='id_trabajador', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pedido'


class Producto(models.Model):
    id_producto = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100, blank=True, null=True)
    precio = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stock = models.IntegerField(blank=True, null=True)
    id_categoria = models.ForeignKey(Categoria, models.DO_NOTHING, db_column='id_categoria', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'producto'


class Usuario(models.Model):
    id_usuario = models.FloatField(primary_key=True)
    nombre = models.CharField(max_length=100, blank=True, null=True)
    rol = models.CharField(max_length=100, blank=True, null=True)
    contrasena = models.CharField(max_length=100, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'usuario'
