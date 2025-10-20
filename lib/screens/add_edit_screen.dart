import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/point_of_sale.dart';
import '../providers/point_of_sale_provider.dart';

class AddEditScreen extends StatefulWidget {
  final PointOfSale? pointOfSale;

  const AddEditScreen({super.key, this.pointOfSale});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _date;
  late String _business;
  late String _owner;
  late String _address;
  late String _city;
  late String _state;
  late String _zipCode;
  late String _phone;
  late int _plateQuantity;
  late String _serialNumbers;

  @override
  void initState() {
    super.initState();
    _date = widget.pointOfSale?.date ?? '';
    _business = widget.pointOfSale?.business ?? '';
    _owner = widget.pointOfSale?.owner ?? '';
    _address = widget.pointOfSale?.address ?? '';
    _city = widget.pointOfSale?.city ?? '';
    _state = widget.pointOfSale?.state ?? '';
    _zipCode = widget.pointOfSale?.zipCode ?? '';
    _phone = widget.pointOfSale?.phone ?? '';
    _plateQuantity = widget.pointOfSale?.plateQuantity ?? 0;
    _serialNumbers = widget.pointOfSale?.serialNumbers ?? '';
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newPointOfSale = PointOfSale(
        id: widget.pointOfSale?.id,
        date: _date,
        business: _business,
        owner: _owner,
        address: _address,
        city: _city,
        state: _state,
        zipCode: _zipCode,
        phone: _phone,
        plateQuantity: _plateQuantity,
        serialNumbers: _serialNumbers,
      );

      if (widget.pointOfSale == null) {
        Provider.of<PointOfSaleProvider>(context, listen: false)
            .addPointOfSale(newPointOfSale);
      } else {
        Provider.of<PointOfSaleProvider>(context, listen: false)
            .updatePointOfSale(newPointOfSale);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pointOfSale == null ? 'Añadir Punto de Venta' : 'Editar Punto de Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _date,
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una fecha.';
                  }
                  return null;
                },
                onSaved: (value) => _date = value!,
              ),
              TextFormField(
                initialValue: _business,
                decoration: const InputDecoration(labelText: 'Comercio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un comercio.';
                  }
                  return null;
                },
                onSaved: (value) => _business = value!,
              ),
              TextFormField(
                initialValue: _owner,
                decoration: const InputDecoration(labelText: 'Dueño'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un dueño.';
                  }
                  return null;
                },
                onSaved: (value) => _owner = value!,
              ),
              TextFormField(
                initialValue: _address,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una dirección.';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                initialValue: _city,
                decoration: const InputDecoration(labelText: 'Ciudad'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una ciudad.';
                  }
                  return null;
                },
                onSaved: (value) => _city = value!,
              ),
              TextFormField(
                initialValue: _state,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un estado.';
                  }
                  return null;
                },
                onSaved: (value) => _state = value!,
              ),
              TextFormField(
                initialValue: _zipCode,
                decoration: const InputDecoration(labelText: 'Código postal'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un código postal.';
                  }
                  return null;
                },
                onSaved: (value) => _zipCode = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un teléfono.';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                initialValue: _plateQuantity.toString(),
                decoration: const InputDecoration(labelText: 'Cantidad de placas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una cantidad.';
                  }
                  return null;
                },
                onSaved: (value) => _plateQuantity = int.parse(value!),
              ),
              TextFormField(
                initialValue: _serialNumbers,
                decoration: const InputDecoration(labelText: 'Números de serie'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese los números de serie.';
                  }
                  return null;
                },
                onSaved: (value) => _serialNumbers = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
