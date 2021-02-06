import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pokedex/Controllers/home_controller.dart';
import 'package:my_pokedex/Controllers/pokemon_controller.dart';
import 'package:my_pokedex/Helpers/text_styles.dart';
import 'package:my_pokedex/Model/pokemon.dart';
import 'package:my_pokedex/utitliy/utils.dart';

class EvolutionTab extends StatelessWidget {
  final Pokemon pokemon;
  final PokemonController pokemonController = Get.find<PokemonController>();
  final HomeController homeController = Get.find<HomeController>();

  EvolutionTab({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: pokemon.evolution.futureBranches != null
          ? ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: pokemon.evolution.futureBranches.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildAvatarWithName(
                                name: pokemon.name,
                                urlIndex: getDexFromName(pokemon.name,
                                        homeController.pokemonList)
                                    .toString()),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset('Assets/loading.gif'),
                                ),
                                Text(
                                  "Evolves To",
                                  style: AppTextStyle.smallBold.copyWith(
                                    color: Color(0xFFB4B5BE),
                                  ),
                                )
                              ],
                            ),
                            buildAvatarWithName(
                                name: pokemon
                                    .evolution.futureBranches[index].name,
                                urlIndex: getDexFromName(
                                        pokemon.evolution.futureBranches[index]
                                            .name,
                                        homeController.pokemonList)
                                    .toString()),
                          ],
                        ),
                      ),
                      //  buildFutureEvolutions(index),
                    ],
                  ),
                );
              },
            )
          : Container(
              margin: const EdgeInsets.only(top: 40),
              alignment: Alignment.topCenter,
              child: Text(
                "No Evolution Found",
                style: AppTextStyle.smallBold,
              ),
            ),
    );
  }

  Column buildAvatarWithName({String urlIndex, String name}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CachedNetworkImageBuilder(
            url: "https://pokeres.bastionbot.org/images/pokemon/" +
                urlIndex +
                ".png",
            builder: (image) {
              return Image.file(image);
            },
            placeHolder: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('Assets/loading.gif'),
            ),
            errorWidget: Image.asset('Assets/poke_ball.png'),
            imageExtensions: ['jpg', 'png'],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: AppTextStyle.smallBold,
        )
      ],
    );
  }

  Widget buildFutureEvolutions(int index) {
    if (pokemon.evolution.futureBranches[index].futureBranches != null) {
      return Expanded(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount:
              pokemon.evolution.futureBranches[index].futureBranches.length,
          itemBuilder: (context, inIndex) {
            return Container(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CachedNetworkImageBuilder(
                          url:
                              "https://pokeres.bastionbot.org/images/pokemon/" +
                                  getDexFromName(
                                          pokemon.evolution
                                              .futureBranches[index].name,
                                          homeController.pokemonList)
                                      .toString() +
                                  ".png",
                          builder: (image) {
                            return Image.file(image);
                          },
                          placeHolder: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('Assets/loading.gif'),
                          ),
                          errorWidget: Image.asset('Assets/poke_ball.png'),
                          imageExtensions: ['jpg', 'png'],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pokemon.evolution.futureBranches[index].name,
                        style: AppTextStyle.smallBold,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset('Assets/loading.gif'),
                      ),
                      Text(
                        "Evolves To",
                        style: AppTextStyle.smallBold.copyWith(
                          color: Color(0xFFB4B5BE),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CachedNetworkImageBuilder(
                          url:
                              "https://pokeres.bastionbot.org/images/pokemon/" +
                                  getDexFromName(
                                          pokemon
                                              .evolution
                                              .futureBranches[index]
                                              .futureBranches[inIndex]
                                              .name,
                                          homeController.pokemonList)
                                      .toString() +
                                  ".png",
                          builder: (image) {
                            return Image.file(image);
                          },
                          placeHolder: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset('Assets/loading.gif'),
                          ),
                          errorWidget: Image.asset('Assets/poke_ball.png'),
                          imageExtensions: ['jpg', 'png'],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pokemon.evolution.futureBranches[index]
                            .futureBranches[inIndex].name,
                        style: AppTextStyle.smallBold,
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}