///旅拍页模型
class TravelItemModel {
  late int totalCount;
  List<TravelItem>? resultList;

  //命名构造方法
  TravelItemModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = new List<TravelItem>.empty(growable: true);
      json['resultList'].forEach((v) {
        resultList!.add(new TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['resultList'] = this.resultList!.map((v) => v.toJson()).toList();
    return data;
  }
}

class TravelItem {
  late int type;
  late Article? article;

  TravelItem(this.type, this.article);

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article = Article.fromJson(json['article']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['article'] = this.article?.toJson();
    return data;
  }
}

class Article {
  late int articleId;
  String? articleType;
  late int productType;
  late int sourceType;
  late String articleTitle;
  Author? author;
  late List<Images> images;
  late bool hasVideo;
  late int readCount;
  late int likeCount;
  late int commentCount;
  late List<Urls> urls;
  late List<Null> tags;
  List<Topics>? topics;
  List<Pois?>? pois;
  late String publishTime;
  late String publishTimeDisplay;
  late String shootTime;
  late String shootTimeDisplay;
  late int level;
  late String distanceText;
  late bool isLike;
  late int imageCounts;
  late bool isCollected;
  late int collectCount;
  late int articleStatus;
  late String poiName;

  Article(
      this.articleId,
      this.articleType,
      this.productType,
      this.sourceType,
      this.articleTitle,
      this.author,
      this.images,
      this.hasVideo,
      this.readCount,
      this.likeCount,
      this.commentCount,
      this.urls,
      this.tags,
      this.topics,
      this.pois,
      this.publishTime,
      this.publishTimeDisplay,
      this.shootTime,
      this.shootTimeDisplay,
      this.level,
      this.distanceText,
      this.isLike,
      this.imageCounts,
      this.isCollected,
      this.collectCount,
      this.articleStatus,
      this.poiName);

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    articleType = json['articleType'];
    productType = json['productType'];
    sourceType = json['sourceType']??0;
    articleTitle = json['articleTitle'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = new List<Images>.empty(growable: true);
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount']??0;
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    if (json['urls'] != null) {
      urls = new List<Urls>.empty(growable: true);
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = new List<Topics>.empty(growable: true);
      json['topics'].forEach((v) {
        topics?.add(new Topics.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = new List<Pois>.empty(growable: true);
      json['pois'].forEach((v) {
        pois!.add(new Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level']??0;
    distanceText = json['distanceText']??'';
    isLike = json['isLike']??false;
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount']??0;
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleId'] = this.articleId;
    data['articleType'] = this.articleType;
    data['productType'] = this.productType;
    data['sourceType'] = this.sourceType;
    data['articleTitle'] = this.articleTitle;
    if (this.author != null) {
      data['author'] = this.author?.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = this.hasVideo;
    data['readCount'] = this.readCount;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    if (this.topics != null) {
      data['topics'] = this.topics?.map((v) => v.toJson()).toList();
    }
    if (this.pois != null) {
      data['pois'] = this.pois!.map((v) => v?.toJson()).toList();
    }
    data['publishTime'] = this.publishTime;
    data['publishTimeDisplay'] = this.publishTimeDisplay;
    data['shootTime'] = this.shootTime;
    data['shootTimeDisplay'] = this.shootTimeDisplay;
    data['level'] = this.level;
    data['distanceText'] = this.distanceText;
    data['isLike'] = this.isLike;
    data['imageCounts'] = this.imageCounts;
    data['isCollected'] = this.isCollected;
    data['collectCount'] = this.collectCount;
    data['articleStatus'] = this.articleStatus;
    data['poiName'] = this.poiName;
    return data;
  }
}

class Author {
  late int authorId;
  late String nickName;
  late String clientAuth;
  late String jumpUrl;
  CoverImage? coverImage;
  int? identityType;
  late String tag;

  Author(this.authorId, this.nickName, this.clientAuth, this.jumpUrl,
      this.coverImage, this.identityType, this.tag);

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId']??0;
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'] != null
        ? new CoverImage.fromJson(json['coverImage'])
        : null;
    identityType = json['identityType'];
    tag = json['tag']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorId'] = this.authorId;
    data['nickName'] = this.nickName;
    data['clientAuth'] = this.clientAuth;
    data['jumpUrl'] = this.jumpUrl;
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage?.toJson();
    }
    data['identityType'] = this.identityType;
    data['tag'] = this.tag;
    return data;
  }
}

class CoverImage {
  late String dynamicUrl;
  late String originalUrl;

  CoverImage(this.dynamicUrl, this.originalUrl);

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    return data;
  }
}

class Images {
  late int imageId;
  late String dynamicUrl;
  late String originalUrl;
  late double width;
  late double height;
  late int mediaType;
  bool? isWaterMarked;

  Images(this.imageId, this.dynamicUrl, this.originalUrl, this.width,
      this.height, this.mediaType, this.isWaterMarked);

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType']??0;
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['mediaType'] = this.mediaType;
    data['isWaterMarked'] = this.isWaterMarked;
    return data;
  }
}

class Urls {
  late String version;
  late String appUrl;
  late String h5Url;
  late String wxUrl;

  Urls(this.version, this.appUrl, this.h5Url, this.wxUrl);

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version']??'';
    appUrl = json['appUrl']??'';
    h5Url = json['h5Url']??'';
    wxUrl = json['wxUrl']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['appUrl'] = this.appUrl;
    data['h5Url'] = this.h5Url;
    data['wxUrl'] = this.wxUrl;
    return data;
  }
}

class Topics {
  late int topicId;
  late String topicName;
  late int level;

  Topics(this.topicId, this.topicName, this.level);

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicId'] = this.topicId;
    data['topicName'] = this.topicName;
    data['level'] = this.level;
    return data;
  }
}

class Pois {
  late int poiType;
  late int poiId;
  late String poiName;
  int? businessId;
  late int districtId;
  PoiExt? poiExt;
  late int source;
  late int isMain;
  late bool isInChina;
  String? countryName;

  Pois(this.poiType, this.poiId, this.poiName, this.businessId, this.districtId,
      this.poiExt, this.source, this.isMain, this.isInChina, this.countryName);

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    poiExt =
    json['poiExt'] != null ? new PoiExt.fromJson(json['poiExt']) : null;
    source = json['source']??0;
    isMain = json['isMain']??0;
    isInChina = json['isInChina']??false;
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poiType'] = this.poiType;
    data['poiId'] = this.poiId;
    data['poiName'] = this.poiName;
    data['businessId'] = this.businessId;
    data['districtId'] = this.districtId;
    if (this.poiExt != null) {
      data['poiExt'] = this.poiExt!.toJson();
    }
    data['source'] = this.source;
    data['isMain'] = this.isMain;
    data['isInChina'] = this.isInChina;
    data['countryName'] = this.countryName;
    return data;
  }
}

class PoiExt {
  late String h5Url;
  late String appUrl;

  PoiExt(this.h5Url, this.appUrl);

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h5Url'] = this.h5Url;
    data['appUrl'] = this.appUrl;
    return data;
  }
}
