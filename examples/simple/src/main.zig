const sentry = @import("sentry");

pub fn main() !void {
    // Create a new options set.
    const opts = sentry.sentry_options_new();
    // Make sure to set the correct DSN.
    sentry.sentry_options_set_dsn(opts, "https://public@sentry.example.com/1");
    // Do not sample errors
    sentry.sentry_options_set_sample_rate(opts, 1.0);
    // Do not sample transactions.
    sentry.sentry_options_set_traces_sample_rate(opts, 1.0);
    // Enable DEBUG, 0 is to turn off the debug logging.
    sentry.sentry_options_set_debug(opts, 1);

    // Initiate the SDK using options we set up before, and now we can use it to sent the events to Sentry.
    _ = sentry.sentry_init(opts);
    // Make sure we release all the resources before the program exits.
    defer _ = sentry.sentry_close();

    // ... Here you can use sentry to start transaction and attach spans to it.
    // ... Also you can capture and send errors.

}
