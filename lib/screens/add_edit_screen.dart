import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late TextEditingController _dateController;
  late TextEditingController _businessController;
  late TextEditingController _ownerController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _phoneController;
  late TextEditingController _plateQuantityController;
  late List<TextEditingController> _serialNumberControllers;
  late List<TextEditingController> _visitDateControllers;
  late TextEditingController _priceController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.pointOfSale?.date ?? '');
    _businessController = TextEditingController(text: widget.pointOfSale?.business ?? '');
    _ownerController = TextEditingController(text: widget.pointOfSale?.owner ?? '');
    _addressController = TextEditingController(text: widget.pointOfSale?.address ?? '');
    _cityController = TextEditingController(text: widget.pointOfSale?.city ?? '');
    _stateController = TextEditingController(text: widget.pointOfSale?.state ?? '');
    _zipCodeController = TextEditingController(text: widget.pointOfSale?.zipCode ?? '');
    _phoneController = TextEditingController(text: widget.pointOfSale?.phone ?? '');
    _plateQuantityController = TextEditingController(text: widget.pointOfSale?.plateQuantity.toString() ?? '0');
    
    final serialNumbers = widget.pointOfSale?.serialNumbers?.split(',').where((sn) => sn.isNotEmpty).toList() ?? [];
    _serialNumberControllers = serialNumbers
        .map((sn) => TextEditingController(text: sn))
        .toList();

    final visits = widget.pointOfSale?.visits?.split(',').where((v) => v.isNotEmpty).toList() ?? [];
    _visitDateControllers = visits
        .map((v) => TextEditingController(text: v))
        .toList();

    _priceController = TextEditingController(text: widget.pointOfSale?.price.toString() ?? '0.0');
    _notesController = TextEditingController(text: widget.pointOfSale?.notes ?? '');
  }

  @override
  void dispose() {
    _dateController.dispose();
    _businessController.dispose();
    _ownerController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    _plateQuantityController.dispose();
    for (var controller in _serialNumberControllers) {
      controller.dispose();
    }
    for (var controller in _visitDateControllers) {
      controller.dispose();
    }
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _addSerialNumberField() {
    setState(() {
      _serialNumberControllers.add(TextEditingController());
    });
  }

  void _removeSerialNumberField(int index) {
    setState(() {
      _serialNumberControllers[index].dispose();
      _serialNumberControllers.removeAt(index);
    });
  }

  void _addVisitField() {
    setState(() {
      _visitDateControllers.add(TextEditingController());
    });
  }

  void _removeVisitField(int index) {
    setState(() {
      _visitDateControllers[index].dispose();
      _visitDateControllers.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat.yMd().format(picked);
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final serialNumbers = _serialNumberControllers
          .map((controller) => controller.text)
          .where((sn) => sn.isNotEmpty)
          .join(',');
      final visits = _visitDateControllers
          .map((controller) => controller.text)
          .where((v) => v.isNotEmpty)
          .join(',');

      final newPointOfSale = PointOfSale(
        id: widget.pointOfSale?.id,
        date: _dateController.text,
        business: _businessController.text,
        owner: _ownerController.text,
        address: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipCodeController.text,
        phone: _phoneController.text,
        plateQuantity: int.parse(_plateQuantityController.text),
        serialNumbers: serialNumbers,
        price: double.parse(_priceController.text),
        notes: _notesController.text,
        visits: visits,
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
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, _dateController),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una fecha.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _businessController,
                decoration: const InputDecoration(labelText: 'Comercio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un comercio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ownerController,
                decoration: const InputDecoration(labelText: 'Dueño'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un dueño.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una dirección.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Ciudad'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una ciudad.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un estado.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(labelText: 'Código postal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un código postal.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un teléfono.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _plateQuantityController,
                decoration: const InputDecoration(labelText: 'Cantidad de placas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese una cantidad.';
                  }
                  return null;
                },
              ),
              ..._buildSerialNumberFields(),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _addSerialNumberField,
                icon: const Icon(Icons.add),
                label: const Text('Añadir número de serie'),
              ),
              const SizedBox(height: 20),
              const Text('Visitas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ..._buildVisitFields(),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _addVisitField,
                icon: const Icon(Icons.add),
                label: const Text('Añadir Visita'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese un precio.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingrese un número válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 3,
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

  List<Widget> _buildSerialNumberFields() {
    return List.generate(_serialNumberControllers.length, (index) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _serialNumberControllers[index],
              decoration: const InputDecoration(labelText: 'Número de serie'),
              validator: (value) => null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => _removeSerialNumberField(index),
          ),
        ],
      );
    });
  }

  List<Widget> _buildVisitFields() {
    return List.generate(_visitDateControllers.length, (index) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _visitDateControllers[index],
              decoration: const InputDecoration(
                labelText: 'Fecha de Visita',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _visitDateControllers[index]),
              validator: (value) => null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => _removeVisitField(index),
          ),
        ],
      );
    });
  }
}
