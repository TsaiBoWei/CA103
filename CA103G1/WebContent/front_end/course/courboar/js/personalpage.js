myApp.config(['$provide', Decorate]);

function Decorate($provide) {
    $provide.decorator('daypickerDirective', function ($delegate) {
        var directive = $delegate[0];
        directive.templateUrl = "custom-template/datepicker/day.html";
        return $delegate;
    });
    $provide.decorator('monthpickerDirective', function ($delegate) {
        var directive = $delegate[0];
        directive.templateUrl = "custom-template/datepicker/month.html";
        return $delegate;
    });
    $provide.decorator('yearpickerDirective', function ($delegate) {
        var directive = $delegate[0];
        directive.templateUrl = "custom-template/datepicker/year.html";
        return $delegate;
    });
};


myApp.config(['$provide', Decorate]);
function Decorate($provide) {
  $provide.decorator('$locale', function ($delegate) {
    var value = $delegate.DATETIME_FORMATS;

    value.SHORTDAY = [
        "S",
        "M",
        "T",
        "W",
        "T",
        "F",
        "S"
    ];

    return $delegate;
  });
};