<?php
/**
 * Title: Affiliation
 * Slug: lifestewardship/affiliation
 */
?>

<!-- wp:columns {"isStackedOnMobile":false,"style":{"spacing":{"padding":{"top":"2.5rem","right":"2.5rem","bottom":"2.5rem","left":"2.5rem"}},"border":{"radius":"0.5rem"}},"backgroundColor":"background-secondary","className":"drop-shadow h-full"} -->
<div
  class="
    wp-block-columns
    is-not-stacked-on-mobile
    drop-shadow h-full
    has-background-secondary-background-color has-background
  "
  style="
    border-radius: 0.5rem;
    padding-top: 2.5rem;
    padding-right: 2.5rem;
    padding-bottom: 2.5rem;
    padding-left: 2.5rem;
  "
>
  <!-- wp:column {"verticalAlignment":"center","width":"48px","className":"shrink-0","lock":{"move":true,"remove":true}} -->
  <div
    class="wp-block-column is-vertically-aligned-center shrink-0"
    style="flex-basis: 48px"
  >
    <!-- wp:image {"width":48,"height":48,"lock":{"move":true,"remove":true}} -->
    <figure class="wp-block-image is-resized">
      <img
        src="<?php echo get_stylesheet_directory_uri(); ?>/images/check.svg"
        alt=""
        width="48"
        height="48"
      />
    </figure>
    <!-- /wp:image -->
  </div>
  <!-- /wp:column -->

  <!-- wp:column {"verticalAlignment":"center","width":"100%","lock":{"move":true,"remove":true}} -->
  <div
    class="wp-block-column is-vertically-aligned-center"
    style="flex-basis: 100%"
  >
    <!-- wp:paragraph {"placeholder":"Type affiliation name","textColor":"foreground-secondary","className":"font-alternate","fontSize":"base","lock":{"move":true,"remove":true}} -->
    <p
      class="
        font-alternate
        has-foreground-secondary-color has-text-color has-base-font-size
      "
    ></p>
    <!-- /wp:paragraph -->
  </div>
  <!-- /wp:column -->
</div>
<!-- /wp:columns -->
