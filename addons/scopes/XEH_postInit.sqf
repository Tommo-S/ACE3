/*
 * Author: KoffeinFlummi, esteldunedain, Ruthberg
 *
 * Watches for scope changes.
 * Defines key bindings
 *
 */
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Check inventory when it changes
["ace_playerInventoryChanged", FUNC(inventoryCheck)] call CBA_fnc_addEventHandler;

// Instantly hide knobs when scoping in
["ace_cameraViewChanged", {
    EXPLODE_2_PVT(_this,_player,_newCameraView);
    if (_newCameraView == "GUNNER") then {
        private "_layer";
        _layer = [QGVAR(Zeroing)] call BIS_fnc_rscLayer;
        _layer cutText ["", "PLAIN", 0];


        if !(isNil QGVAR(fadePFH)) then {
            [GVAR(fadePFH)] call CBA_fnc_removePerFrameHandler;
            GVAR(fadePFH) = nil;
        };
    };
}] call CBA_fnc_addEventHandler;


// Add keybinds
["ACE3 Scope Adjustment", QGVAR(AdjustUpMinor), localize LSTRING(AdjustUpMinor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, ELEVATION_UP, MINOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[201, [false, false, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustDownMinor), localize LSTRING(AdjustDownMinor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, ELEVATION_DOWN, MINOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[209, [false, false, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustLeftMinor), localize LSTRING(AdjustLeftMinor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, WINDAGE_LEFT, MINOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[209, [false, true, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustRightMinor), localize LSTRING(AdjustRightMinor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, WINDAGE_RIGHT, MINOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[201, [false, true, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustUpMajor), localize LSTRING(AdjustUpMajor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, ELEVATION_UP, MAJOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[201, [true, false, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustDownMajor), localize LSTRING(AdjustDownMajor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, ELEVATION_DOWN, MAJOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[209, [true, false, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustLeftMajor), localize LSTRING(AdjustLeftMajor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, WINDAGE_LEFT, MAJOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[209, [true, true, false]], true] call CBA_fnc_addKeybind;

["ACE3 Scope Adjustment", QGVAR(AdjustRightMajor), localize LSTRING(AdjustRightMajor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isNotInside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (!([ACE_player] call CBA_fnc_canUseWeapon)) exitWith {false};

    [ACE_player] call FUNC(inventoryCheck);

    // Statement
    [ACE_player, WINDAGE_RIGHT, MAJOR_INCREMENT] call FUNC(adjustScope);
},
{false},
[201, [true, true, false]], true] call CBA_fnc_addKeybind;


// Register fire event handler
["ace_firedPlayer", DFUNC(firedEH)] call CBA_fnc_addEventHandler;
["ace_firedPlayerNonLocal", DFUNC(firedEH)] call CBA_fnc_addEventHandler;
