// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helloWorldHash() => r'ea721097ce01b1f980f0840bc365b8a66e7468bb';

/// We create a "provider", which will store a value (here "Hello world").
/// By using a provider, this allows us to mock/override the value exposed.
///
/// Copied from [helloWorld].
@ProviderFor(helloWorld)
final helloWorldProvider = AutoDisposeProvider<String>.internal(
  helloWorld,
  name: r'helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$helloWorldHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HelloWorldRef = AutoDisposeProviderRef<String>;
String _$getItemModelHash() => r'ba52929e2ee93a7eb70adcc489ecbe2bb551a759';

/// This will create a provider named `getItemModelProvider`
/// which will cache the result of this function.
///
/// Copied from [getItemModel].
@ProviderFor(getItemModel)
final getItemModelProvider = AutoDisposeFutureProvider<ItemModel>.internal(
  getItemModel,
  name: r'getItemModelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getItemModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetItemModelRef = AutoDisposeFutureProviderRef<ItemModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
