# RSIGNIN — one-time core sign (UNSIGNED draft)

**What Rizal signs, once:** the SHA-256 `e5b2fc68f8121dd025bfa81f666c21a4d88417333837b70ebbe18558fd19dd04` of `RSIGNIN-CHARTER.canonical.json` (sorted keys, no whitespace, UTF-8).

**How:** on Neo, a P-256 key created *by Rizal* inside the Secure Enclave (non-exportable, Touch ID required per use) signs that hash. ThundR never creates, sees or stores the private key.
Output: `RSIGNIN-CHARTER.sig` (base64 ECDSA-P256-SHA256) + `RSIGNIN-PUBKEY.pem` (public only).

**How apps verify (verify-only):**
1. Re-canonicalize the charter, recompute SHA-256, compare to `.sha256`.
2. Verify `.sig` against the bundled/pulled `RSIGNIN-PUBKEY.pem`.
3. Check `REVOKED.json` absent (or not validly signed); check the requested action is in `scope` and not in `exclusions`.
4. Any failure = refuse and ask for a per-action GO.

**Revoke:** Rizal signs `REVOKED.json` with the same key; DISTRIBUTE it.
Status: charter drafted 2026-10-24 by ThundR · ЯID-0014-KREH. No key created or touched.
