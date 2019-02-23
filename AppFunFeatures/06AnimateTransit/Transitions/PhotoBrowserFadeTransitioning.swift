//
//  PhotoBrowserFadeTransitioning.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

public class PhotoBrowserFadeTransitioning: PhotoBrowserTransitioning {
    public override init() {
        super.init()
        self.presentingAnimator = PhotoBrowserFadePresentingAnimator()
        self.dismissingAnimator = PhotoBrowserFadeDismissingAnimator()
    }
}


