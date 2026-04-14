from django.shortcuts import render,redirect, get_object_or_404
from django.http import HttpResponse
from django.contrib import messages
from .models import *
from .forms import *
from django.db import transaction
from datetime import *

# Create your views here.
def saludo(request):
    return HttpResponse("prueba exitosa")

def listarProductos(request):
    productos = Producto.objects.all()
    return render(request, 'app/Productos.html', {'productos':productos})

def crearProductos(request):
    if request.session.get('usuario_rol') != 'admin':
        messages.error(request, "No tienes permiso para crear productos.")
        return redirect('listarProductos')
    if request.method == 'POST':
        form  = ProductoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('listarProductos')
    else:
        form = ProductoForm()
    return render(request, 'app/crearProducto.html',{'form':form})
def elimnarProducto(request, id_producto):
    if request.session.get('usuario_rol') != 'admin':
        messages.error(request, "No tienes permiso para crear productos.")
        return redirect('listarProductos')
    producto = get_object_or_404(Producto, id_producto=id_producto)
    producto.delete()
    return redirect('listarProductos')
def editarProducto(request, id_producto):
    if request.session.get('usuario_rol') != 'admin':
        messages.error(request, "No tienes permiso para crear productos.")
        return redirect('listarProductos')
    producto = get_object_or_404(Producto, id_producto=id_producto)
    if request.method == "POST":
        form = ProductoForm(request.POST, instance=producto)
        if form.is_valid():
            form.save()
            return redirect('listarProductos')
    else:
        form = ProductoForm(instance=producto)
    return render(request, 'app/editarProducto.html', {'form': form})

def login(request):
    if 'usuario_id' in request.session:
        if request.session.get('usuario_rol') == 'cajero':
            return redirect('panelCajero')
        return redirect('listarProductos')
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            nombre = form.cleaned_data['nombre']
            contrasena_ingresada = form.cleaned_data['contrasena']
            try:
                usuario= Usuario.objects.get(nombre=nombre)
                if usuario.contrasena == contrasena_ingresada:
                    request.session['usuario_id'] = usuario.id_usuario
                    request.session['usuario_nombre'] = usuario.nombre
                    request.session['usuario_rol'] = usuario.rol
                    if usuario.rol == 'cajero':
                        return redirect('panelCajero')
                    else:
                        return redirect('listarProductos')
                else:
                    messages.error(request, 'Contraseña Incorrecta')
            except:
                messages.error(request, 'Usuario No encontrado')
    else:
        form = LoginForm()
    return render(request, 'app/Login.html', {'form':form})


def logout(request):
    request.session.flush()
    return redirect('login')

def panelCajero(request):
    if request.session.get('usuario_rol') != 'cajero':
        messages.error(request, 'No tienes permisos para acceder a la caja')
    pedidosPendientes = Pedido.objects.filter(estado='Pendiente')
    
    return render(request, 'app/panelCajero.html', {'pedidos' : pedidosPendientes})

def cobrarPedido(request, id_pedido):
    if request.session.get('usuario_rol') != 'cajero':
        return redirect ('login')
    pedido = get_object_or_404(Pedido, id_pedido=id_pedido)
    pedido.estado='Cobrado'
    pedido.save()
    
    messages.success(request,'pedido cobrado exitosamente')
    return redirect('panelCajero')


def confirmarPedido(request):
    if request.session.get('usuario_rol') != 'trabajador':
        return redirect('login')
    if request.method == 'POST':
        nombre_cliente = request.POST.get('nombre_cliente')
        carrito = request.session.get('carrito',{})
        id_trabajador = request.session.get('usuario_id')
        
        if not carrito:
            messages.error(request, "El carrito esta vacio")
            return redirect('listarProductos')
        
        with transaction.atomic():
                nuevo_pedido = Pedido.objects.create(
                    nombre_cliente=nombre_cliente,
                    fecha= date.today(),
                    estado = 'Pendiente',
                    id_trabajador_id = id_trabajador
                )
            
                for id_producto, cantidad in carrito.items():
                    producto = Producto.objects.get(id_producto=id_producto)
                    subtotal = producto.precio * cantidad
                
                    DetallePedido.objects.create(
                        id_pedido = nuevo_pedido,
                        id_producto = producto,
                        cantidad = cantidad,
                        subtotal = subtotal
                    )
                    producto.stock -= cantidad
                    producto.save()
                del request.session['carrito']
        
    return redirect('listarProductos')

def agregarAlCarrito(request, id_producto):
    if request.session.get('usuario_rol') != 'trabajador':
        return redirect('login')
    carrito = request.session.get('carrito', {})
    id_prod_str = str(id_producto)
    if id_prod_str in carrito:
        carrito[id_prod_str]+=1
    else:
        carrito[id_prod_str] =1
    request.session['carrito'] = carrito
    return redirect ('listarProductos')
    
def verCarrito(request):
    if request.session.get('usuario_rol') != 'trabajador':
        return redirect('login')
    
    carrito = request.session.get('carrito', {})
    productosEnCarrito = []
    totalPedido = 0
    
    for id_prod_str, cantidad in carrito.items():
        producto = Producto.objects.get(id_producto = float(id_prod_str))
        subtotal = producto.precio * cantidad
        totalPedido +=subtotal
        productosEnCarrito.append({
            'producto':producto,
            'cantidad' : cantidad,
            'subtotal' : subtotal
        })
    return render(request, 'app/Carrito.html', {'productosEnCarrito' : productosEnCarrito, 'total': totalPedido })
    