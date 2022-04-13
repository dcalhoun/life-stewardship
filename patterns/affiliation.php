<?php
/**
 * Title: Affiliation
 * Slug: life-stewardship/affiliation
 */
?>

<!-- wp:columns {"isStackedOnMobile":false,"style":{"spacing":{"padding":{"top":"2.5rem","right":"2.5rem","bottom":"2.5rem","left":"2.5rem"}},"border":{"radius":"0.5rem"}},"backgroundColor":"background-secondary","className":"ls-drop-shadow ls-h-full"} -->
<div
  class="
    wp-block-columns
    is-not-stacked-on-mobile
    ls-drop-shadow ls-h-full
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
  <!-- wp:column {"verticalAlignment":"center","width":"48px","className":"ls-shrink-0","lock":{"move":true,"remove":true}} -->
  <div
    class="wp-block-column is-vertically-aligned-center ls-shrink-0"
    style="flex-basis: 48px"
  >
    <!-- wp:image {"width":48,"height":48,"lock":{"move":true,"remove":true}} -->
    <figure class="wp-block-image is-resized">
      <img
        src="<?php echo get_stylesheet_directory_uri(); ?>/assets/check.svg"
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
    <!-- wp:paragraph {"placeholder":"Type affiliation name","textColor":"foreground-secondary","className":"ls-font-alternate","fontSize":"base","lock":{"move":true,"remove":true}} -->
    <p
      class="
        ls-font-alternate
        has-foreground-secondary-color has-text-color has-base-font-size
      "
    ></p>
    <!-- /wp:paragraph -->
  </div>
  <!-- /wp:column -->
</div>
<!-- /wp:columns -->
