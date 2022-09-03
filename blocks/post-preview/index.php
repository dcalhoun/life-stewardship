<?php

/**
 * Render server-side version of block.
 */
function lifestewardship_post_preview_render(
    $block_attributes,
    $content,
    $block
) {
    $post_id = $block->context["postId"];
    $title = get_the_title($post_id);
    $link = get_the_permalInk($post_id);
    $date = get_the_date("F d, Y", $post_id);
    $dateTime = get_the_date("Y-m-d", $post_id);
    $featured_image_url = get_the_post_thumbnail_url($post_id);
    return wp_sprintf(
        '
    <a href="%2$s" title="%1$s - Published on %3$s" style="display: block;">
        <img
            aria-hidden="true"
            class="is-style-rounded"
            height="100"
            src="%5$s"
            width="100"
        />
        <h2 aria-hidden="true">%1$s</h2>
        <time aria-hidden="true" dateTime="%3$s">%4$s</time>
    </a>',
        esc_html($title),
        esc_url($link),
        $dateTime,
        $date,
        esc_url($featured_image_url),
    );
}

/**
 * Register custom block tupe.
 */
function lifestewardship_post_preview_block() {
    register_block_type(__DIR__, [
        "render_callback" => "lifestewardship_post_preview_render",
    ]);
}
add_action("init", "lifestewardship_post_preview_block");
