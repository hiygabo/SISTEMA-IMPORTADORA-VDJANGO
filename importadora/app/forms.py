from django import forms
from .models import *

class ProductoForm(forms.ModelForm):
    class Meta:
        model = Producto
        fields=['nombre', 'precio', 'stock', 'id_categoria']
        widgets={
            'nombre': forms.TextInput(attrs={'class' : 'form-control'}),
            'precio': forms.NumberInput(attrs={'class': 'form-control'}),
            'stock': forms.NumberInput(attrs={'class': 'form-control'}),
            'id_categoria': forms.Select(attrs={'class': 'form-control'})
        }
class LoginForm(forms.Form):
    nombre = forms.CharField(max_length=100, widget=forms.TextInput(attrs={'class': 'form-control'}))
    contrasena = forms.CharField(widget=forms.PasswordInput, label='Contraseña')