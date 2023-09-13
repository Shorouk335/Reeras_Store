import 'package:flutter/material.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Prodect_Dialog.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storecubit.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

class ProdectBox extends StatefulWidget {
  final Products? product;

  const ProdectBox({super.key, this.product});

  @override
  State<ProdectBox> createState() => _ProdectBoxState();
}

class _ProdectBoxState extends State<ProdectBox> {
  @override
  Widget build(BuildContext context) {
    StoreCubit storeCubit = StoreCubit.get(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(7.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Image(
                    image: NetworkImage(widget.product?.imageUrl ?? ""),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => Image(
                      image:  AssetImage("assets/images/pic.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                  title: const Text(
                                    'Edit product',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content:
                                      ProdectDialog(products: widget.product));
                            },
                          ).then((value) =>
                              storeCubit.getStoreDataCubit(pageNamber: 1));
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 25.0,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          storeCubit.deleteStoreDataCubit(
                              id: widget.product?.id ?? 0);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 25.0,
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.product?.name ?? "shosho"}",
                      style: const TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    Text(
                      "${widget.product?.description ?? "hhhhhhhhh"}",
                      style: const TextStyle(fontSize: 8.0, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 20.0,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.product?.id ?? 0}",
                          style: const TextStyle(fontSize: 15.0),
                        ),
                        const Spacer(),
                        Text(
                          "${widget.product?.price ?? 25} \$",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
