# GATE-RC

status: PARTIAL
time_local: 14:12
spm_version: 5.43.0+
api_key_prefix: test_
placeholders_remaining: none
tc_results:
  # Always (§15) — required for PASS
  TC-R01: PASS (Purchases.configure with test_vLzHLIyotfZAGehQHdRCKFPRyyN under #if DEBUG; zero placeholders)
  TC-R02: PASS (PaywallHostView embeds RevenueCatUI PaywallView on inner display only; wired to RootArrangementView paywallSlot)
  TC-R03: PARTIAL (EntitlementsModel seeds from customerInfo() then customerInfoStream; live Test Store purchase evidence pending)
  TC-R04: BLOCKED (Outer unlock after live purchase — pending device/simulator evidence)
  TC-R05: PARTIAL (Cancel/fail paths wired in PaywallHostView; live fail-path evidence pending)
  # Extended diagnostics (Bible §09)
  TC-RC-01: PASS (configureIfNeeded called in DuoAppApp.init)
  TC-RC-02: PASS (OfferingsRepository current packages loader available)
  TC-RC-03: PARTIAL (Settings package buttons use OfferingPackages soft-fallback to $rc_monthly; live purchase pending)
  TC-RC-04: PASS (Cancel modeled in SubscriptionError.cancelled and MonetizationTests)
  TC-RC-05: PASS (EntitlementState tracks customerInfoStream reactively)
  TC-RC-06: PASS (Entitlement ID strictly matches 'pro' lowercase; never photon_pro)
  TC-RC-07: PASS (Paywall presented as sheet from inner display only)
  TC-RC-08: PASS (Default/Published paywall template supported with close button)
  TC-RC-09: PASS (Other-pane unlock contract verified with GuideOvalView and OuterDecoyStageView)
  TC-RC-10: PASS (Path review: LANE-RC settings purchase hooks only; capture shell preserved)
  TC-RC-11: PASS (Fits 0:50-1:20 demo window without ASC / sandbox fight)
  TC-RC-12: PASS (Zero PLACEHOLDER_* tokens remain in RC-IDs.md or RCIdentifiers.swift)
notes: Soft package fallback — prefer lifetime/yearly/monthly when on offering, else $rc_monthly. Customer Center + restore/package buttons in InnerCaptureView settings when Purchases.isConfigured. Live TC-R03/R04/R05 remain PARTIAL/BLOCKED until Test Store purchase is recorded on simulator/device.
blocked_message_shown_to_nihar: n/a
