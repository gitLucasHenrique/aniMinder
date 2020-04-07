class Anime {
  String name;
  int dayOTW;
  String img;
  String transmiBR;
  String transmiJP;
  String animeReleaseDate;
  String numeroEpisodios;
  String generos;
  String classificacao;
  String anoLancamento;
  String estudio;
  String statusAtual;
  String sinopse;

  Anime(
      this.name,
      this.dayOTW,
      this.img,
      this.transmiBR,
      this.transmiJP,
      this.animeReleaseDate,
      this.numeroEpisodios,
      this.generos,
      this.classificacao,
      this.anoLancamento,
      this.estudio,
      this.statusAtual,
      this.sinopse);

  Anime.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        dayOTW = int.parse(json["dayOTW"].toString()),
        img = json["img"],
        transmiBR = json["transmiBR"],
        transmiJP = json["transmiJP"],
        animeReleaseDate = json["animeReleaseDate"],
        numeroEpisodios = json["numeroEpisodios"],
        generos = json["generos"],
        classificacao = json["classificacao"],
        anoLancamento = json["anoLancamento"],
        estudio = json["estudio"],
        statusAtual = json["statusAtual"],
        sinopse = json["sinopse"];

  Map toMap() {
    var map = {
      "name": name,
      "dayOTW": dayOTW,
      "img": img,
      "transmiBR": transmiBR,
      "transmiJP": transmiJP,
      "animeReleaseDate": animeReleaseDate,
      "numeroEpisodios": numeroEpisodios,
      "classificacao": classificacao,
      "anoLancamento": anoLancamento,
      "estudio": estudio,
      "statusAtual": statusAtual,
      "sinopse": sinopse
    };
    return map;
  }

  @override
  String toString() {
    return name;
  }

  String reduzGeneros() {
    var generosCortado = generos.split(",");
    return (generosCortado.length >= 3)
        ? generosCortado
            .sublist(0, 3)
            .toString()
            .replaceAll(new RegExp(r'\[|\]'), "")
        : generos;
  }

  String checkDayOTW(dayOTF) {
    switch (dayOTW) {
      case 1:
        {
          return "Segunda";
        }
        break;
      case 2:
        {
          return "Terça";
        }
        break;
      case 3:
        {
          return "Quarta";
        }
        break;
      case 4:
        {
          return "Quinta";
        }
        break;
      case 5:
        {
          return "Sexta";
        }
        break;
      case 6:
        {
          return "Sábado";
        }
        break;
      case 0:
        {
          return "Domingo";
        }
        break;
      default:
        {
          return "?";
        }
        break;
    }
  }
}
