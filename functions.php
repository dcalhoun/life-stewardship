<?php
/**
 * Functions and definitions
 *
 * @link https://developer.wordpress.org/themes/basics/theme-functions/
 */

/**
 * Enqueue theme support
 */
if (!function_exists("life_stewardship_support")) {
    function life_stewardship_support() {
        // Alignwide and alignfull classes in the block editor.
        add_theme_support("align-wide");
        // Add support for experimental link color control.
        add_theme_support("experimental-link-color");
        // Add support for responsive embedded content.
        // https://github.com/WordPress/gutenberg/issues/26901
        add_theme_support("responsive-embeds");
        // Add support for post thumbnails.
        add_theme_support("post-thumbnails");
        // Declare that there are no <title> tags and allow WordPress to provide them
        add_theme_support("title-tag");
        // Experimental support for adding blocks inside nav menus
        add_theme_support("block-nav-menus");
        // Add support for editor styles.
        add_theme_support("editor-styles");
        add_theme_support("automatic-feed-links");
        add_theme_support("wp-block-styles");

        add_filter("block_editor_settings_all", function ($settings) {
            $settings["defaultBlockTemplate"] =
                '<!-- wp:group {"layout":{"inherit":true}} --><div class="wp-block-group"><!-- wp:post-content /--></div><!-- /wp:group -->';
            return $settings;
        });

        // Add support for core custom logo.
        add_theme_support("custom-logo", [
            "height" => 192,
            "width" => 192,
            "flex-width" => true,
            "flex-height" => true,
        ]);
    }
}
add_action("after_setup_theme", "life_stewardship_support");

/**
 * Enqueue the style.css file.
 */
function life_stewardship_styles() {
    wp_enqueue_style(
        "global",
        get_stylesheet_uri(),
        wp_get_theme()->get("Version"),
    );
    wp_enqueue_style(
        "tailwind",
        "https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css",
        wp_get_theme()->get("Version"),
    );
}
add_action("wp_enqueue_scripts", "life_stewardship_styles");
