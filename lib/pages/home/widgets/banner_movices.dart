import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/pages/detail/components/slider_card_image.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_see_all.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/pages/widgets/no_connection_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/resources/app_values.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_api/src/models/navi/navi_avtor.dart';

import 'package:movies_api/src/models/navi/navi_link.dart';

class BannerMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("s");
  }
}
