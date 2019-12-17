@import UIKit;
@import UserNotifications;
@class WMFTheme;
@class WMFLegacyArticleViewController;
@class MWKDataStore;
@class WMFTheme;
@class WMFArticleContainerViewController;

NS_ASSUME_NONNULL_BEGIN

@interface WMFAppViewController : UITabBarController <UNUserNotificationCenterDelegate>

@property (nonatomic, readonly, nullable) UINavigationController *currentNavigationController;
@property (nonatomic, readonly) WMFTheme *theme;
@property (nonatomic, readonly) MWKDataStore *dataStore;

- (void)launchAppInWindow:(UIWindow *)window waitToResumeApp:(BOOL)waitToResumeApp;

- (void)showSplashViewIfNotShowing;

- (void)hideSplashViewAnimated:(BOOL)animated;

- (void)hideSplashScreenAndResumeApp; // Updates explore feed & other heavy network lifitng

- (void)processShortcutItem:(UIApplicationShortcutItem *)item completion:(void (^)(BOOL))completion;

- (BOOL)processUserActivity:(NSUserActivity *)activity animated:(BOOL)animated completion:(dispatch_block_t)done;

- (void)performBackgroundFetchWithCompletion:(void (^)(UIBackgroundFetchResult))completion;

- (void)applyTheme:(WMFTheme *)theme;

- (void)showSearchInCurrentNavigationController;

//tonitodo: delete old, rename new
- (WMFLegacyArticleViewController *)showArticleForURL:(NSURL *)articleURL animated:(BOOL)animated completion:(nonnull dispatch_block_t)completion;

//tonitodo: return articleVC?
- (void)showNewArticleForURL:(NSURL *)articleURL animated:(BOOL)animated completion:(nonnull dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
