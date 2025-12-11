import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar/ui/screens/shopping_cart_screen.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../models/recomended_item.dart';
import '../../utils/services/favourites_manager.dart';
import '../../utils/themes/app_colors.dart';
import '../../utils/themes/app_styles.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_floating_action_bar.dart';
import '../widgets/custom_navigation_btn.dart';
import 'item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final double _fabSize = 60.0;
  final double _notchWidth = 80.0;
  final double _notchHeight = 80.0;
  final double _bottomBarHeight = 80.0;
  final double _notchCornerRadius = 65.0;

  bool _needsRefresh = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBody: true,
      appBar: CustomAppbar(
        title: "Inicio",
        actions: [
          IconButton(
            visualDensity: VisualDensity(horizontal: -3.0),
            icon: Image.asset('assets/images/notifications_ic.png'),
            onPressed: () {},
          ),
          IconButton(
            visualDensity: VisualDensity(horizontal: -3.0),
            icon: Image.asset('assets/images/setting_ic.png'),
            onPressed: () {},
          ),
        ],
      ),

      body: Stack(
        children: [
          _buildPageContent(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              fabSize: _fabSize,
              notchWidth: _notchWidth,
              notchHeight: _notchHeight,
              bottomBarHeight: _bottomBarHeight,
              notchCornerRadius: _notchCornerRadius,
            ),
          ),

          Positioned(
            bottom: (_bottomBarHeight / 2) - (_fabSize / 2),
            left: (screenWidth / 2) - (_fabSize / 2),
            child: CustomFloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                );
              },
              fabSize: _fabSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: _bottomBarHeight + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explorar categorias',
                    style: AppStyles.listTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'Ver todos',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            SizedBox(
              height: 80.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 19.w, right: 16.w),
                itemCount: Category.allCategories.length,
                itemBuilder: (context, index) {
                  final category = Category.allCategories[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.r),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 64.w,
                              height: 64.w,
                              decoration: BoxDecoration(
                                color: AppColors.getCategoryColor(index)
                                    .withOpacity(0.47),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Center(
                                child: Image.asset(category.imagePath),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              category.name,
                              style: AppStyles.categoryText,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                'Productos populares',
                style: AppStyles.listTitle,
              ),
            ),

            SizedBox(
              height: 214.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Stack(
                      children: [
                        Container(
                          width: 174.w,
                          height: 214.h,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<bool>(
                                future: FavoritesManager.isFavorite(product.id, 'populares'),
                                builder: (context, snapshot) {
                                  bool favorited = snapshot.data ?? false;
                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () async {
                                        await FavoritesManager.toggleFavorite(product.id, 'populares');
                                        setState(() {});
                                      },
                                      child: Icon(
                                        favorited ? Icons.favorite : Icons.favorite_border,
                                        color: favorited ? Colors.red : Colors.grey,
                                        size: 20.sp,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 8.h),

                              Center(
                                child: Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF209BD0).withOpacity(
                                            0.5),
                                        blurRadius: 22,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 70.w,
                                      height: 70.w,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                        product.imagePath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Spacer(),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            product.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                              color: Color(0xFF515F65),
                                            ),
                                          ),
                                          Text(
                                            product.description,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 7.sp,
                                              color: Color(0xFF515F65),
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            '\$${product.price}',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomNavigationBtn(onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ItemDetailsScreen(
                                            id: product.id,
                                            category: 'populares',
                                            name: product.name,
                                            description: product.description,
                                            imagePath: product.imagePath,
                                            price: product.price,
                                            onFavoriteChanged: (value) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 25.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                "Recomendados",
                style: AppStyles.listTitle,
              ),
            ),

            SizedBox(
              height: 130.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: recommendedItems.length,
                itemBuilder: (context, index) {
                  final item = recommendedItems[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 240.w,
                          height: 104.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 100.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          item.category,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () async {
                                            await FavoritesManager
                                                .toggleFavorite(
                                                item.id, 'recomendados');
                                            setState(() {});
                                          },
                                          child: FutureBuilder<bool>(
                                            future: FavoritesManager.isFavorite(
                                                item.id, 'recomendados'),
                                            builder: (context, snapshot) {
                                              bool fav = snapshot.data ?? false;
                                              return Icon(
                                                fav ? Icons.favorite : Icons
                                                    .favorite_border,
                                                color: fav ? Colors.red : Colors
                                                    .grey,
                                                size: 20.sp,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: Color(0xFF515F65),
                                      ),
                                    ),
                                    Text(
                                      item.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 9.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "\$${item.price}",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        CustomNavigationBtn(onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ItemDetailsScreen(
                                                id: item.id,
                                                category: 'recomendados',
                                                name: item.name,
                                                description: item.description,
                                                imagePath: item.imagePath,
                                                price: item.price,
                                                onFavoriteChanged: (value) {
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          left: 10.w,
                          bottom: -2.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              item.imagePath,
                              width: 90.w,
                              height: 115.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}