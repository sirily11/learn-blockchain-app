//
//  Generated file. Do not edit.
//

// clang-format off

import FlutterMacOS
import Foundation

import file_chooser
import native_pdf_renderer
import package_info
import path_provider_macos
import shared_preferences_macos
import url_launcher_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FileChooserPlugin.register(with: registry.registrar(forPlugin: "FileChooserPlugin"))
  NativePdfRendererPlugin.register(with: registry.registrar(forPlugin: "NativePdfRendererPlugin"))
  FLTPackageInfoPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
}
