//------------------------------------------------------------------------------
// Copyright (c) 2021 Ginee. All rights reserved.
// Use of this source code is governed by the license that can be
// found in the LICENSE file.
//------------------------------------------------------------------------------

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:stockdaddy/exceptions/exceptions.dart';
import 'package:stockdaddy/models/model.dart';

/// {@macro sd.abstract.model.repo}
///
/// This implementation is based on [FirebaseFirestore].
/// Override methods to customize the firestore interaction for
/// specific [M] model.
class SDFirebaseDefaultRepo {
  /// {@macro sd.abstract.model.repo}
  /// [path] is the collection path in firestore
  SDFirebaseDefaultRepo({
    required String path,
    FirebaseFirestore? firebaseFirestore,
  })  : _path = path,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // ---------------------------------------------------------------------------

  final _log = Logger('[SDFirebaseDefaultRepo] >>>>');

  final String _path;
  final FirebaseFirestore _firebaseFirestore;

  // ---------------------------------------------------------------------------

  /// {@macro sd.abstract.model.repo.findByTitle}
  /// used to fetch the specific document from firestore using title.
  /// Also convert the fetched Document.
  Future findByTitle(String title) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('tasks')
          .where('title', isEqualTo: title)
          .get();
      _log.fine('Found document by title $title');
      if (snapshot.size == null) {
        return snapshot.docs.first.data();
      }
      throw SDRepoException('model by title $title not found');
    } on Exception catch (it, stacktrace) {
      _log.shout('model by title $title not found', it, stacktrace);
      rethrow;
    }
  }

  List<SDTaskModel> getAll() {
    List<SDTaskModel> models = [];
    // await _firebaseFirestore
    //     .collection('task')
    //     .where(field, isGreaterThanOrEqualTo: '')
    //     .snapshots()
    //     .map((snap) => snap.docs
    //         .map((e) => models.add(SDTaskModel.fromJson(e.data())))
    // .toList());
    // return models;
    _firebaseFirestore.collection('tasks').snapshots().listen((tasks) {
      for (var element in tasks.docs) {
        models.add(SDTaskModel.fromJson(element.data()));
        // print(element.data());
      }
    });

    return models;

    // final snapshot = _firebaseFirestore
    //     .collection('task')
    //     .where(field, isGreaterThanOrEqualTo: '')
    //     .snapshots()

    // for (var e in snapshot) {
    //   results.add(e.data());
    // }

    // SDTaskModel.fromJson(snapshot.then((value) => null));
  }

  /// {@macro od.abstract.model.repo.save}
  /// [M] model to add or update in firestore.
  /// it will create new model if document for it does not exist.
  Future<void> save(SDTaskModel taskModel) async {
    try {
      // update the existing document
      if (taskModel.uid != null && taskModel.uid!.isNotEmpty) {
        await _firebaseFirestore.collection('tasks').doc(taskModel.uid).update(
              SDTaskModel.modelToMap(taskModel),
            );
        _log.info('UPDATED existing document for model $taskModel');
      }
      // or create new document
      else {
        await _firebaseFirestore.collection('tasks').add(
              SDTaskModel.modelToMap(taskModel),
            );
        _log.info('CREATED new document for model $taskModel');
      }
      _log.fine('Saved/updated a document for ${taskModel.runtimeType} type');
    } on Exception {
      _log.shout('FAILED to save model $taskModel');
      rethrow;
    }
  }

  /// {@macro od.abstract.model.repo.delete}
  /// use to delete single model provided by M
  @override
  Future<void> delete(SDTaskModel taskModel) async {
    try {
      await _firebaseFirestore.collection('tasks').doc(taskModel.uid).delete();
      _log.fine('Delete the model with id: ${taskModel.uid}');
    } on Exception catch (it, trace) {
      _log.shout('Unable to delete model $taskModel', it, trace);
      throw SDRepoException('model delete failed $taskModel', it, runtimeType);
    }
  }
}
