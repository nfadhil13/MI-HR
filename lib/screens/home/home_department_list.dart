import 'package:flutter/material.dart';
import 'package:movie_app/provider/department_provider.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/department_card.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/provider/provider_state.dart';

class HomeDepartmentList extends StatefulWidget {
  const HomeDepartmentList({Key? key}) : super(key: key);

  @override
  _HomeDepartmentListState createState() => _HomeDepartmentListState();
}

class _HomeDepartmentListState extends State<HomeDepartmentList> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DepartmentProvider>(context, listen: false)
          .getDepartmentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartmentProvider>(builder: (_, departmentProvider, __) {
      final tobeRenderedWidget = departmentProvider.currentState.when<SliverChildDelegate>(
        onIdle: () => SliverChildBuilderDelegate(
            (ctx,index){
              return DepartmentCard(departmentProvider.twoTopDepartments[index], index, () {});
            },
          childCount: departmentProvider.twoTopDepartments.length
        ),
        onError: () => SliverChildListDelegate.fixed(
          [
            Container(
              alignment: Alignment.center,
                child: Text("Gagal mendapatkan data department"))
          ]
        ),
        onLoading: () =>SliverChildListDelegate.fixed(
            [
              Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: ThemeColors.primaryThird,))
            ]
        )
      );
      return tobeRenderedWidget != null ? SliverList(delegate: tobeRenderedWidget) : SizedBox();
    }
    );
  }
}
