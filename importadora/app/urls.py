from django.urls import path
from . import views

urlpatterns = [
    path('', views.login, name='inicio'),
    path('saludo/', views.saludo, name='saludo'),
    path('productos/', views.listarProductos, name='listarProductos'),
    path('crearProducto/', views.crearProductos, name='crearProducto'),
    path('editarProducto/<int:id_producto>/', views.editarProducto, name='editarProducto'),
    path('eliminarProducto/<int:id_producto>/', views.elimnarProducto, name='eliminarProducto'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('panelCajero/', views.panelCajero, name='panelCajero'),
    path('cobrarPedido/<int:id_pedido>/', views.cobrarPedido, name='cobrarPedido'),
    path('confirmarPedido/', views.confirmarPedido, name='confirmarPedido' ),
    path('agregarAlcarrito/<int:id_producto>/', views.agregarAlCarrito, name='agregarAlCarrito'),
    path('verCarrito/', views.verCarrito, name='verCarrito'),
]