import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sehetak2/screens/medicine-remminder/database/repository.dart';
import 'package:sehetak2/screens/medicine-remminder/models/pill.dart';
import 'package:sehetak2/screens/medicine-remminder/notifications/notifications.dart';

class MedicineCard extends StatefulWidget {

  final Pill medicine;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicineCard(this.medicine,this.setData,this.flutterLocalNotificationsPlugin);

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > widget.medicine.time;

    return Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Colors.white,
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onLongPress: () =>
                _showDeleteDialog(context, widget.medicine.name, widget.medicine.id, widget.medicine.notifyId),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              widget.medicine.name,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${widget.medicine.amount} ${widget.medicine.medicineForm}",
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(widget.medicine.time)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
            leading: Container(
              width: 60.0,
              height: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(
                      widget.medicine.image
                    )),
              ),
            )));
  }

  void _showDeleteDialog(BuildContext context, String medicineName, int medicineId, int notifyId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Delete ?"),
              content: Text("Are you sure to delete $medicineName medicine?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                FlatButton(
                  splashColor: Color.fromRGBO(7, 190, 200, 1).withOpacity(0.3),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Color.fromRGBO(7, 190, 200, 1)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  splashColor: Color.fromRGBO(7, 190, 200, 1).withOpacity(0.3),
                  child: Text("Delete",
                      style: TextStyle(color: Color.fromRGBO(7, 190, 200, 1))),
                  onPressed: () async {
                    await Repository().deleteData('Pills', medicineId);
                    await Notifications().removeNotify(notifyId, widget.flutterLocalNotificationsPlugin);
                    widget.setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
