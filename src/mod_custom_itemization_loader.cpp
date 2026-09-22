/*
 * mod-custom-itemization loader.
 *
 * The playerbots fork auto-globs every module's sources into one lib and looks
 * up a loader symbol derived from the folder name: for folder "mod-custom-itemization"
 * that symbol is exactly "Addmod_custom_itemizationScripts". It must exist and call our
 * real registration function.
 *
 * Released under GNU GPL v2 or (at your option) any later version.
 */

void AddCustomItemizationScripts();

void Addmod_custom_itemizationScripts()
{
    AddCustomItemizationScripts();
}
