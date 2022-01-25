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

/**
 * Disable embeds script to improve performance.
 */
function disable_embeds() {
    wp_dequeue_script("wp-embed");
}
add_action("wp_footer", "disable_embeds");

/**
 * Disable the emojis to improve performance.
 */
function disable_emojis() {
    remove_action("wp_head", "print_emoji_detection_script", 7);
    remove_action("admin_print_scripts", "print_emoji_detection_script");
    remove_action("wp_print_styles", "print_emoji_styles");
    remove_action("admin_print_styles", "print_emoji_styles");
    remove_filter("the_content_feed", "wp_staticize_emoji");
    remove_filter("comment_text_rss", "wp_staticize_emoji");
    remove_filter("wp_mail", "wp_staticize_emoji_for_email");
    add_filter(
        "wp_resource_hints",
        "disable_emojis_remove_dns_prefetch",
        10,
        2,
    );
}
add_action("init", "disable_emojis");

/**
 * Remove emoji CDN hostname from DNS prefetching hints.
 *
 * @param array $urls URLs to print for resource hints.
 * @param string $relation_type The relation type the URLs are printed for.
 * @return array Difference betwen the two arrays.
 */
function disable_emojis_remove_dns_prefetch($urls, $relation_type) {
    if ("dns-prefetch" == $relation_type) {
        /** This filter is documented in wp-includes/formatting.php */
        $emoji_svg_url = apply_filters(
            "emoji_svg_url",
            "https://s.w.org/images/core/emoji/2/svg/",
        );

        $urls = array_diff($urls, [$emoji_svg_url]);
    }

    return $urls;
}
