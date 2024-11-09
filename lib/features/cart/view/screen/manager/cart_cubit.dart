import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:shop_sql/app.dart';
import 'package:shop_sql/core/data_base/shop_data_base.dart';
import 'package:shop_sql/core/helpers/safe_print.dart';
import 'package:shop_sql/features/cart/model/cart_model.dart';
import 'package:shop_sql/features/favourite/model/line_voice_model.dart';
import 'package:pdf/widgets.dart' as pw;

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int invoiceId = 0;
  addInvoice({
    required CartModel cartModel,
  }) async {
    ShopDatabase.addInvoice(totalPrice: cartModel.totalAfterVat).then((value) {
      safePrint("invoice id $value");
      invoiceId = value;
      for (int i = 0; i < cartModel.cartItems.length; i++) {
        safePrint("interation $i");
        ShopDatabase.addLineVoice(
            lineVoiceModel: LineVoiceModel(
          invoiceId: value,
          productId: cartModel.cartItems[i].id,
          quantity: cartModel.cartItems[i].quantity,
          price: cartModel.cartItems[i].totalItemPrice,
        ));
      }
      cartModel.cartItems.clear();
      emit(CheckOutSuccessState());
    });
  }

  getInvoice({required int id}) async {
    ShopDatabase.getInvoice(id).then((value) async {
      getLineVoice(id: value.id).then((onValue) async {
        final pdf = pw.Document();
        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "invoice number: ${value.id}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 22.sp,
                        color: PdfColors.red),
                  ),
                  pw.Text(
                    "total price: ${value.totalPrice}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 22.sp),
                  ),
                ]),
            pw.Expanded(
                child: pw.ListView.builder(
              itemCount: onValue.length,
              itemBuilder: (Context context, int index) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("product id ${onValue[index].productId}",
                        style: pw.TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                          color: PdfColors.blue,
                        )),
                    pw.Text("quantity ${onValue[index].quantity}",
                        style: pw.TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                          color: PdfColors.blue,
                        )),
                    pw.Text("total price ${onValue[index].price}",
                        style: pw.TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                          color: PdfColors.blue,
                        )),
                  ],
                );
              },
            )),
          ]);
        }));

        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save(),
        );
      });
    });
  }

  Future<List<LineVoiceModel>> getLineVoice({required int id}) async {
    final list = await ShopDatabase.getLineVoice(invoiceId: id);
    List<LineVoiceModel> lineVoiceModels = list;
    return lineVoiceModels;
  }
}
