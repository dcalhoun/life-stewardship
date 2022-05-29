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
    $link = get_the_permalink($post_id);
    $date = get_the_date("Y-m-d", $post_id);
    $featured_image_url = get_the_post_thumbnail_url($post_id);
    return wp_sprintf(
        '
    <article role="listitem">
      <a href="%2$s" title="%1$s - Published on %3$s" style="display: block;">
        <img
            aria-hidden="true"
            class="is-style-rounded"
            height="100"
            src="%4$s"
            width="100"
        />
        <h2 aria-hidden="true">%1$s</h2>
        <time aria-hidden="true">%3$s</time>
      </a>
    </article>',
        esc_html($title),
        esc_url($link),
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
