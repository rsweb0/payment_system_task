// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");

ReactRailsUJS.handleEvent('turbo:load', ReactRailsUJS.handleMount);
ReactRailsUJS.handleEvent('turbo:before-render', ReactRailsUJS.handleUnmount);

ReactRailsUJS.useContext(componentRequireContext);
