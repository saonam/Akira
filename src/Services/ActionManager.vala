/*
* Copyright (c) 2019 Alecaddd (http://alecaddd.com)
*
* This file is part of Akira.
*
* Akira is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.

* Akira is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with Akira.  If not, see <https://www.gnu.org/licenses/>.
*
* Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
*/

using Akira.Lib.Managers;

public class Akira.Services.ActionManager : Object {
    public weak Akira.Application app { get; construct; }
    public weak Akira.Window window { get; construct; }

    public SimpleActionGroup actions { get; construct; }

    public FileManager file_manager;

    public const string ACTION_PREFIX = "win.";
    public const string ACTION_NEW_WINDOW = "action_new_window";
    public const string ACTION_OPEN = "action_open";
    public const string ACTION_SAVE = "action_save";
    public const string ACTION_SAVE_AS = "action_save_as";
    public const string ACTION_SHOW_PIXEL_GRID = "action-show-pixel-grid";
    public const string ACTION_SHOW_UI_GRID = "action-show-ui-grid";
    public const string ACTION_PRESENTATION = "action_presentation";
    public const string ACTION_PREFERENCES = "action_preferences";
    public const string ACTION_EXPORT = "action_export";
    public const string ACTION_QUIT = "action_quit";
    public const string ACTION_ZOOM_IN = "action_zoom_in";
    public const string ACTION_ZOOM_OUT = "action_zoom_out";
    public const string ACTION_ZOOM_RESET = "action_zoom_reset";
    public const string ACTION_MOVE_UP = "action_move_up";
    public const string ACTION_MOVE_DOWN = "action_move_down";
    public const string ACTION_MOVE_TOP = "action_move_top";
    public const string ACTION_MOVE_BOTTOM = "action_move_bottom";
    public const string ACTION_RECT_TOOL = "action_rect_tool";
    public const string ACTION_ELLIPSE_TOOL = "action_ellipse_tool";
    public const string ACTION_TEXT_TOOL = "action_text_tool";
    public const string ACTION_SELECTION_TOOL = "action_selection_tool";
    public const string ACTION_DELETE = "action_delete";

    public static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();

    private const ActionEntry[] ACTION_ENTRIES = {
        { ACTION_NEW_WINDOW, action_new_window },
        { ACTION_OPEN, action_open },
        { ACTION_SAVE, action_save },
        { ACTION_SAVE_AS, action_save_as },
        { ACTION_SHOW_PIXEL_GRID, action_show_pixel_grid },
        { ACTION_SHOW_UI_GRID, action_show_ui_grid },
        { ACTION_PRESENTATION, action_presentation },
        { ACTION_PREFERENCES, action_preferences },
        { ACTION_EXPORT, action_export },
        { ACTION_QUIT, action_quit },
        { ACTION_ZOOM_IN, action_zoom_in },
        { ACTION_ZOOM_OUT, action_zoom_out },
        { ACTION_MOVE_UP, action_move_up },
        { ACTION_MOVE_DOWN, action_move_down },
        { ACTION_MOVE_TOP, action_move_top },
        { ACTION_MOVE_BOTTOM, action_move_bottom },
        { ACTION_ZOOM_RESET, action_zoom_reset },
        { ACTION_RECT_TOOL, action_rect_tool },
        { ACTION_ELLIPSE_TOOL, action_ellipse_tool },
        { ACTION_TEXT_TOOL, action_text_tool },
        { ACTION_SELECTION_TOOL, action_selection_tool },
        { ACTION_DELETE, action_delete },
    };

    public ActionManager (Akira.Application akira_app, Akira.Window window) {
        Object (
            app: akira_app,
            window: window
        );
        file_manager = new FileManager (window);
    }

    static construct {
        action_accelerators.set (ACTION_NEW_WINDOW, "<Control>n");
        action_accelerators.set (ACTION_OPEN, "<Control>o");
        action_accelerators.set (ACTION_SAVE, "<Control>s");
        action_accelerators.set (ACTION_SAVE_AS, "<Control><Shift>s");
        action_accelerators.set (ACTION_SHOW_PIXEL_GRID, "<Control><Shift>p");
        action_accelerators.set (ACTION_SHOW_UI_GRID, "<Control><Shift>g");
        action_accelerators.set (ACTION_PRESENTATION, "<Control>period");
        action_accelerators.set (ACTION_PREFERENCES, "<Control>comma");
        action_accelerators.set (ACTION_EXPORT, "<Control><Shift>e");
        action_accelerators.set (ACTION_QUIT, "<Control>q");
        action_accelerators.set (ACTION_ZOOM_IN, "<Control>plus");
        action_accelerators.set (ACTION_ZOOM_OUT, "<Control>minus");
        action_accelerators.set (ACTION_ZOOM_RESET, "<Control>0");
        action_accelerators.set (ACTION_MOVE_UP, "<Control>Up");
        action_accelerators.set (ACTION_MOVE_DOWN, "<Control>Down");
        action_accelerators.set (ACTION_MOVE_TOP, "<Control><Shift>Up");
        action_accelerators.set (ACTION_MOVE_BOTTOM, "<Control><Shift>Down");
    }

    construct {
        actions = new SimpleActionGroup ();
        actions.add_action_entries (ACTION_ENTRIES, this);
        window.insert_action_group ("win", actions);

        foreach (var action in action_accelerators.get_keys ()) {
            app.set_accels_for_action (ACTION_PREFIX + action, action_accelerators[action].to_array ());
        }
    }

    private void action_quit () {
        window.before_destroy ();
    }

    private void action_presentation () {
        window.headerbar.toggle ();
        window.main_window.left_sidebar.toggle ();
        window.main_window.right_sidebar.toggle ();
    }

    private void action_new_window () {
        app.new_window ();
    }

    private void action_open () {
        file_manager.open_file ();
    }

    private void action_save (SimpleAction action, Variant? parameter) {
        file_manager.save_file ();
    }

    private void action_save_as (SimpleAction action, Variant? parameter) {
        file_manager.save_as ();
    }

    private void action_show_pixel_grid () {
        warning ("show pixel grid");
    }

    private void action_show_ui_grid () {
        warning ("show UI grid");
    }

    private void action_preferences () {
        var settings_dialog = new Akira.Widgets.SettingsDialog (window);
        settings_dialog.show_all ();
        settings_dialog.present ();
    }

    private void action_export () {
        warning ("export");
    }

    private void action_zoom_in () {
        window.headerbar.zoom.zoom_in ();
    }

    private void action_zoom_out () {
        window.headerbar.zoom.zoom_out ();
    }

    private void action_zoom_reset () {
        window.headerbar.zoom.zoom_reset ();
    }

    private void action_move_up () {
        //window.main_window.main_canvas.canvas.change_z_selected (true, false);
    }

    private void action_move_down () {
        //window.main_window.main_canvas.canvas.change_z_selected (false, false);
    }

    private void action_move_top () {
        //window.main_window.main_canvas.canvas.change_z_selected (true, true);
    }

    private void action_move_bottom () {
        //window.main_window.main_canvas.canvas.change_z_selected (false, true);
    }

    private void action_rect_tool () {
        window.main_window.main_canvas.canvas.edit_mode = Akira.Lib.Canvas.EditMode.MODE_INSERT;
        //window.main_window.main_canvas.canvas.insert_type = Akira.Lib.Canvas.InsertType.RECT;
        window.event_bus.insert_item ("rectangle");
        window.event_bus.close_popover ("insert");
    }

    private void action_selection_tool () {
        window.main_window.main_canvas.canvas.edit_mode = Akira.Lib.Canvas.EditMode.MODE_SELECTION;
        //window.main_window.main_canvas.canvas.insert_type = null;
    }

    private void action_delete () {
        //window.main_window.main_canvas.canvas.delete_selected ();
    }

    private void action_ellipse_tool () {
        window.main_window.main_canvas.canvas.edit_mode = Akira.Lib.Canvas.EditMode.MODE_INSERT;
        //window.main_window.main_canvas.canvas.insert_type = Akira.Lib.Canvas.InsertType.ELLIPSE;
        window.event_bus.insert_item ("ellipse");
        window.event_bus.close_popover ("insert");
    }

    private void action_text_tool () {
        window.main_window.main_canvas.canvas.edit_mode = Akira.Lib.Canvas.EditMode.MODE_INSERT;
        //window.main_window.main_canvas.canvas.insert_type = Akira.Lib.Canvas.InsertType.TEXT;
        window.event_bus.insert_item ("text");
        window.event_bus.close_popover ("insert");
    }

    public static void action_from_group (string action_name, ActionGroup? action_group) {
        action_group.activate_action (action_name, null);
    }
}
