import 'package:sehetak2/models/product.dart';
import 'package:sehetak2/provider/products.dart';
import 'package:sehetak2/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoriesFeedsScreen';

  const CategoriesFeedsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context).settings.arguments as String;
    print(categoryName);
    final productsList = productsProvider.findByCategory(categoryName);
    return Scaffold(
      body: productsList.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(1.0),
              child: const Text(
                'No Products related to this Category',
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.78,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: List.generate(productsList.length, (index) {
                  return ChangeNotifierProvider.value(
                    value: productsList[index],
                    child: FeedProducts(),
                  );
                }),
              ),
            ),
//         StaggeredGridView.countBuilder(
//           padding: ,
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}
