import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

ImageProvider getImageProvider(String url) {
  try {
    return CachedNetworkImageProvider(url);
  } catch (e) {
    return const AssetImage('assets/images/example.jpg');
  }
}
