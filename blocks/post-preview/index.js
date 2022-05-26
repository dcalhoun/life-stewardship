import { registerBlockType } from "@wordpress/blocks";
import block from "./block.json";
import Edit from "./edit";
import save from "./save";

registerBlockType(block.name, { edit: Edit, save });
