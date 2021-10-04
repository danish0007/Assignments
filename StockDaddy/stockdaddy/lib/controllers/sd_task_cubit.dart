//------------------------------------------------------------------------------
// Copyright (c) 2021 Ginee. All rights reserved.
// Use of this source code is governed by the license that can be
// found in the LICENSE file.
//------------------------------------------------------------------------------

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:stockdaddy/models/model.dart';
import 'package:stockdaddy/repository/sd_default_model_repo.dart';

part 'sd_task_cubit.g.dart';

/// This Task Cubit is used to maintain the state of tasks
class SDTaskCubit extends Cubit<SDTaskCubitState> {
  /// const constructor
  SDTaskCubit({
    required SDFirebaseDefaultRepo repo,
  })  : _repo = repo,
        super(SDTaskCubitState(
            taskModel: null, fieldInputMap: SDTaskModel.modelToMap(null)));

  /// Access the injected service
  /// Avoid using unless overriding a method while extending
  final SDFirebaseDefaultRepo _repo;

  // Initial State
  final _log = Logger('[SDTaskCubit] >>>>>');

  void update(String field, dynamic value) {
    final updatedMap = Map<String, dynamic>.from(state.fieldInputMap);
    updatedMap[field] = value;
    _log.info(updatedMap[field]);
    _log.info(
      'Comparing states ${updatedMap[field] != state.fieldInputMap[field]}',
    );
    emit(
      state.copyWith(
        fieldInputMap: updatedMap,
      ),
    );
  }

  /// To delete the model of type SDTaskModel.
  Future<void> delete() async {
    _log.shout('deleting ${state.taskModel.toString()}');
    await _repo.delete(state.taskModel!);
  }

  /// To save/update model of type SDTaskModel.
  Future<SDTaskModel?> save() async {
    final update = SDTaskModel.mapToModel(state.taskModel, state.fieldInputMap);
    try {
      _log.info('Triggered save method with $update');
      await _repo.save(update);
      _log.fine('Saved successfully');
      return update;
    } catch (it, trace) {
      _log.shout('Unable to save $update', it, trace);
      rethrow;
    }
  }

  // Future<List<SDTaskModel>> getAll() async {
  //   // List<SDTaskModel> model = await _repo.getAll();
  //   // print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  //   // print(model);
  //   // return model;
  // }

  Future<void> addTags(String tag) async {
    var tags = state.fieldInputMap[SDTaskModel.kTags];
    if (tags != null) {
      tags.add(tag);
    } else {
      tags = [tag];
    }
    update(SDTaskModel.kTags, tags);
  }
}

/// {@template od.editor.cubit.state}
/// for managing the list of models.
///
/// {@endtemplate}
@CopyWith()
class SDTaskCubitState extends Equatable {
  /// {@macro sd.task.cubit.state}
  const SDTaskCubitState({
    this.models = const [],
    this.taskModel,
    this.fieldInputMap = const <String, Object>{},
  });

  /// contains list of selected models
  final List<SDTaskModel> models;
  final SDTaskModel? taskModel;
  final Map<String, dynamic> fieldInputMap;

  @override
  List<Object?> get props => [models];
}
