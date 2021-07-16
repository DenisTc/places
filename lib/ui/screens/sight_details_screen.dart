import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';

class SightDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: [
          Container(
            height: 360,
            color: Colors.brown,
            child: Stack(
              children: [
                _PlaceImage(),
                _ArrowBackButton(),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          mocks[0].name,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(fontSize: 24),
                        )
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          mocks[0].type,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: Opacity(
                            opacity: 0.56,
                            child: Text(
                              'закроется в 20:00',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      mocks[0].details,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 24),
                    _CreateRouteButton(),
                    SizedBox(height: 24),
                    Divider(
                      height: 4,
                      color: textColorSecondary,
                    ),
                    SizedBox(height: 19),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color, //Color.fromRGBO(59, 62, 91, 0.56),
                                ),
                              ),
                              SizedBox(width: 9),
                              Text(
                                'Запланировать',
                                style:
                                    Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(width: 14),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 14),
                              Container(
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color, //textColorPrimary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text(
                                  'В избранное',
                                  style:
                                      Theme.of(context).textTheme.bodyText1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 11)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CreateRouteButton extends StatelessWidget {
  const _CreateRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 328,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: lightGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.earbuds_rounded,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Построить маршрут'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  const _PlaceImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      mocks[0].url,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}

class _ArrowBackButton extends StatelessWidget {
  const _ArrowBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          top: 36,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 17,
          color: Theme.of(context).iconTheme.color,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: 32,
        height: 32,
      ),
    );
  }
}
