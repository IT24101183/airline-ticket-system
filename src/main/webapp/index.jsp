<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Air Ticket Reservation System — Home</title>

    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <style>
      :root {
        --black: #111;
        --red: #bd4242;
        --gray-light: #f1f1f1;
        --input-bg: #f5f5f5;
        --nav-height: 72px;
        --card-radius: 10px;
        --font-sans: "Poppins", system-ui, -apple-system, "Segoe UI", Roboto,
          "Helvetica Neue", Arial;
      }
      * {
        box-sizing: border-box;
      }
      body {
        font-family: var(--font-sans);
        background: #fff;
        color: #111;
        margin: 0;
        padding: 0;
      }
      header {
        position: sticky;
        top: 0;
        background: var(--black);
        height: var(--nav-height);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        z-index: 1000;
      }
      .header-inner {
        max-width: 1200px;
        width: 100%;
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 0 16px;
        position: relative;
      }
      .logo-rect {
        position: absolute;
        left: -103px;
        top: -25px;
        display: flex;
        align-items: center;
        gap: 8px;
      }
      .logo-rect img {
        height: 150px;
        width: auto;
        border-radius: 5px;
      }
      .nav-links {
        display: flex;
        gap: 18px;
        margin: auto;
        color: #fff;
      }
      .nav-links a {
        color: #fff;
        text-decoration: none;
        opacity: 0.95;
      }
      .auth-links {
        position: absolute;
        right: 16px;
      }
      .auth-links a {
        color: #fff;
        text-decoration: none;
        margin-left: 10px;
      }

      /* Narrower hero rectangle centered on page */
      .hero {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 35px 20px;
        box-sizing: border-box;
        background: none; /* remove full-width bg */
      }

      /* the visible red rectangle */
      .hero-inner {
        background: linear-gradient(90deg, #a3a0a0 0%, #a3a0a0 100%);
        width: 100%;
        max-width: 1100px; /* reduce this to make rectangle narrower */
        margin: 0 auto;
        padding: 120px; /* inner spacing inside red rectangle */
        border-radius: 8px;
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: space-between;
      }

      /* Hero */
      /* .hero {
        background: linear-gradient(90deg, #a3a0a0 0%, #a3a0a0 100%);
        width: 100%;
        height: 400px;
        padding: 120px 16px;
        color: #fff;
        text-align: left;
      } */

      /* Hero inner use for text move horizontaly */
      /* .hero-inner {
        max-width: 1090px;
        margin: 0 auto;
        display: flex;
        gap: 20px;
        align-items: center;
      } */
      .hero-text h1 {
        font-size: 34px;
        margin-bottom: 6px;
        letter-spacing: 1px;
      }
      .hero-text p {
        opacity: 0.95;
        margin-bottom: 12px;
      }
      .hero-learn {
        background: #bd4242;
        color: var(--white);
        border: none;
        padding: 10px 16px;
        border-radius: 6px;
        font-weight: 600;
      }

      /* Search box overlapping hero */
      .search-box {
        max-width: 1100px;
        margin: -28px auto 28px;
        background: #0b0b0b;
        color: #fff;
        border-radius: 12px;
        padding: 18px;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.35);
      }
      .trip-type {
        display: flex;
        gap: 20px;
        align-items: center;
      }
      .search-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 16px;
        margin-top: 12px;
        align-items: start;
      }
      .field label {
        display: block;
        font-size: 13px;
        color: #ddd;
        margin-bottom: 6px;
      }

      /* Inputs and selects chane boxes diamensions */
      .field input[type="text"],
      .field input[type="date"],
      .field input[type="number"],
      .field select {
        width: 100%;
        height: 68px;
        padding: 12px;
        border-radius: 8px;
        border: none;
        background: var(--input-bg);
        font-size: 15px;
        color: #111;
      }
      .field .icon-placeholder {
        position: absolute;
        left: 12px;
        top: 42px;
        transform: translateY(-50%);
        width: 22px;
        height: 22px;
        pointer-events: none;
      }
      .field-with-icon {
        position: relative;
      }
      .date-range {
        display: flex;
        gap: 8px;
      }
      .date-range input {
        flex: 1;
        padding: 10px 12px;
        height: 48px;
        background: var(--input-bg);
        border-radius: 8px;
        border: none;
      }

      .passengers-field {
        position: relative;
      }
      .passenger-dropdown {
        position: absolute;
        top: 56px;
        left: 0;
        background: #fff;
        color: #111;
        border-radius: 8px;
        padding: 12px;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.12);
        display: none;
        z-index: 1200;
        width: 260px;
      }
      .passenger-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 6px 0;
      }
      .passenger-row button {
        width: 34px;
        height: 34px;
        border-radius: 50%;
        border: none;
        background: #eee;
        font-size: 18px;
        cursor: pointer;
      }
      .passenger-row .count {
        min-width: 28px;
        text-align: center;
        display: inline-block;
      }

      .search-actions {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        gap: 0px;
      }
      .search-btn {
        height: 68px;
        background: var(--red);
        border: none;
        color: #fff;
        padding: 18px;
        border-radius: 10px;
        font-weight: 700;
      }

      /* Cards / Info */
      .info-sections {
        max-width: 1200px;
        margin: 24px auto;
        padding: 0 16px;
      }
      .info-inner {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 18px;
      }
      .info-card {
        background: #fff;
        border-radius: 10px;
        padding: 18px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
        color: #111;
      }

      /* Footer */
      .site-footer {
        background: #0b0b0b;
        color: #ddd;
        padding: 28px 16px;
        margin-top: 28px;
      }
      .footer-inner {
        max-width: 1200px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 18px;
      }

      /* Responsive */
      @media (max-width: 1000px) {
        .search-grid {
          grid-template-columns: repeat(2, 1fr);
        }
      }





      @media (max-width: 700px) {
        .hero-inner {
          flex-direction: column;
          text-align: center;
        }
        .nav-links {
          display: none;
        }
        .search-grid {
          grid-template-columns: 1fr;
        }
        .search-actions {
          flex-direction: row;
        }
        .passenger-dropdown {
          width: 100%;
        }
        .footer-inner {
          grid-template-columns: 1fr;
        }
        .logo-rect {
          left: 8px;
        }
      }
    </style>
  </head>

  <body>
    <!-- HEADER -->
    <header>
      <div class="header-inner">
        <div class="logo-rect" aria-hidden="true">
          <img src="LOGO.png" alt="Site logo" />
        </div>

        <nav class="nav-links" aria-label="Primary navigation">
          <a href="#" class="nav-link">Home</a>
          <a href="#" class="nav-link">Services</a>
          <a href="#" class="nav-link">Contact</a>
          <a href="#" class="nav-link">About</a>
        </nav>

        <div class="auth-links">
          <!-- preserved original login/register links exactly as requested -->
          <a href="login.jsp" class="btn btn-outline-light btn-sm">Login</a>
          <a href="register.jsp" class="btn btn-outline-light btn-sm"
            >Register</a
          >
        </div>
      </div>
    </header>

    <!-- HERO -->
    <section class="hero" aria-label="Promotional banner">
      <div class="hero-inner">
        <div class="hero-text">
          <p style="margin: 0; font-weight: 600; opacity: 0.95">
            Search for flights below. Login to book.
          </p>
          <h1 style="margin-top: 8px; margin-bottom: 6px">
            Welcome to Air Ticket Reservation System
          </h1>
          <p style="margin: 0 0 8px 0; opacity: 0.95">
            Fast, simple flight search and booking experience.
          </p>
          <button class="hero-learn">Learn more</button>
        </div>
        <div style="margin-left: auto">
          <!-- optional small graphic / placeholder -->
          <img
            src="plane-illustration.png"
            alt=""
            style="height: 120px; opacity: 0.95"
          />
        </div>
      </div>
    </section>

    <!-- SEARCH BOX (keeps your original form fields and form action) -->
    <section class="search-box" aria-label="Flight search form">
      <form
        action="search"
        method="get"
        class="row gx-0 gy-2 align-items-start"
      >
        <!-- keep a small trip-type toggle (no harm) -->
        <div class="col-12">
          <div class="trip-type">
            <label class="form-check-label text-white">
              <input
                class="form-check-input ms-2 me-1"
                type="radio"
                name="trip"
                value="return"
                checked
              />
              Return
            </label>
            <label class="form-check-label text-white">
              <input
                class="form-check-input ms-2 me-1"
                type="radio"
                name="trip"
                value="oneway"
              />
              One way
            </label>
          </div>
        </div>

        <div class="col-12">
          <div class="search-grid">
            <!-- Departure Airport (original name preserved) -->
            <div class="field field-with-icon">
              <label for="departure_airport" class="form-label"
                >Departure Airport:</label
              >
              <div class="icon-placeholder">
                <img
                  src="geo-location-pin-vector-icon-removebg-preview.png"
                  alt=""
                  style="width: 100%; height: 100%"
                />
              </div>
              <input
                type="text"
                id="departure_airport"
                name="departure_airport"
                class="form-control"
                placeholder="     Bandaranaike Intl (CMB)"
                required
              />
            </div>

            <!-- Arrival Airport (original name preserved) -->
            <div class="field field-with-icon">
              <label for="arrival_airport" class="form-label"
                >Arrival Airport:</label
              >
              <div class="icon-placeholder">
                <img
                  src="images-removebg-preview.png"
                  alt=""
                  style="width: 100%; height: 100%"
                />
              </div>
              <input
                type="text"
                id="arrival_airport"
                name="arrival_airport"
                class="form-control"
                placeholder="      Colombo (CMB)"
                required
              />
            </div>

            <!-- Departure Date (original name preserved) -->
            <div class="field">
              <label for="departure_date" class="form-label"
                >Departure Date:</label
              >
              <input
                type="date"
                id="departure_date"
                name="departure_date"
                class="form-control"
                required
              />
            </div>

            <!-- (Optional) Return Date - shown/hidden by JS when One way selected.
                 We add this extra input but we do NOT remove the original departure_date field. -->
            <!-- <div class="field date-range" style="grid-column: 1 / span 2">
              <div style="flex: 1">
                <label for="departing_small" class="form-label"
                  >Departing</label
                >
                <input
                  type="date"
                  id="departing_small"
                  class="form-control"
                  aria-label="Departing date"
                />
              </div>
              <div style="flex: 1">
                <label for="returning" class="form-label">Returning</label>
                <input
                  type="date"
                  id="returning"
                  class="form-control"
                  aria-label="Returning date"
                />
              </div>
            </div> -->

            <!-- Number of Passengers (original name preserved). We keep this numeric input and
                 also provide an enhanced passengers picker that updates this value. -->
            <div class="field passengers-field">
              <label for="passengers" class="form-label"
                >Number of Passengers:</label
              >
              <input
                type="number"
                id="passengers"
                name="passengers"
                class="form-control"
                min="1"
                value="1"
                required
              />
              <!-- fancy dropdown: will toggle and update the above numeric input -->
              <div
                class="passenger-dropdown"
                id="passenger-dropdown"
                aria-hidden="true"
              >
                <div class="passenger-row" data-type="Adult">
                  <span>Adult</span>
                  <div>
                    <button type="button" class="minus">−</button>
                    <span class="count">1</span>
                    <button type="button" class="plus">+</button>
                  </div>
                </div>
                <div class="passenger-row" data-type="Child">
                  <span>Child</span>
                  <div>
                    <button type="button" class="minus">−</button>
                    <span class="count">0</span>
                    <button type="button" class="plus">+</button>
                  </div>
                </div>
                <div class="passenger-row" data-type="Infant">
                  <span>Infant</span>
                  <div>
                    <button type="button" class="minus">−</button>
                    <span class="count">0</span>
                    <button type="button" class="plus">+</button>
                  </div>
                </div>
                <div style="text-align: right; margin-top: 8px">
                  <button
                    type="button"
                    id="done-passengers"
                    class="btn btn-sm btn-outline-secondary"
                  >
                    Done
                  </button>
                </div>
              </div>
            </div>

            <!-- Class (original name preserved and original options kept) -->
            <div class="field">
              <label for="flight_class" class="form-label">Class:</label>
              <select
                id="flight_class"
                name="flight_class"
                class="form-select"
                required
              >
                <option value="economy">Economy</option>
                <option value="business">Business</option>
              </select>
            </div>

            <!-- Search button: keep as submit so original form behavior works -->
            <div class="search-actions" style="grid-column: 3 / span 1">
              <label style="visibility: hidden">Search</label>
              <button type="submit" class="search-btn btn btn-block">
                Search Flights
              </button>
              <!-- small hint -->
              <small style="display: block; margin-top: 8px; color: #bbb"
                >Login to book and complete payment.</small
              >
            </div>
          </div>
        </div>
      </form>
    </section>

    <!-- INFO CARDS (kept content but styled) -->
    <section class="info-sections" aria-label="Information sections">
      <div class="info-inner">
        <article class="info-card">
          <h3>About us</h3>
          <p>
            We are SkyLink — a customer-focused airline reservation system built
            for ease of use. Our mission is to provide fast, reliable booking
            and great customer support.
          </p>
        </article>

        <article class="info-card">
          <h3>How to book</h3>
          <p>
            Use the search box above to find flights. Choose dates, passengers
            and class, then click "Search Flights". Follow the booking flow to
            enter passenger details and payment.
          </p>
        </article>

        <article class="info-card">
          <h3>Travel information</h3>
          <p>
            Check baggage rules, visa & passport requirements, and health
            advisories before you travel.
          </p>
        </article>
      </div>
    </section>

    <!-- FOOTER -->
    <footer class="site-footer" role="contentinfo">
      <div class="footer-inner">
        <div>
          <h5>About us</h5>
          <ul style="list-style: none; padding: 0; margin: 0; font-size: 14px">
            <li>
              <a href="#" style="color: #ddd; text-decoration: none"
                >About us</a
              >
            </li>
            <li>
              <a href="#" style="color: #ddd; text-decoration: none">Careers</a>
            </li>
          </ul>
        </div>

        <div>
          <h5>Help</h5>
          <ul style="list-style: none; padding: 0; margin: 0; font-size: 14px">
            <li>
              <a href="#" style="color: #ddd; text-decoration: none"
                >Help and Contact</a
              >
            </li>
            <li>
              <a href="#" style="color: #ddd; text-decoration: none">FAQ</a>
            </li>
          </ul>
        </div>

        <div>
          <h5>Subscribe</h5>
          <form id="subscribe-form" onsubmit="return false;">
            <input
              type="email"
              id="footer-email"
              placeholder="Your email"
              aria-label="Subscribe email"
              required
              style="
                padding: 8px;
                border-radius: 6px;
                border: none;
                background: #111;
                color: #fff;
                width: 100%;
              "
            />
            <button
              type="submit"
              class="btn btn-sm mt-2"
              style="background: var(--red); color: #fff; border: none"
            >
              Subscribe
            </button>
          </form>
        </div>
      </div>

      <div
        style="
          max-width: 1200px;
          margin: 18px auto 0;
          color: #999;
          font-size: 13px;
          padding: 0 16px;
        "
      >
        © 2025 The YasinduDharmasiri Group. All Rights Reserved. ·
        <a href="#" style="color: #bbb">Privacy policy</a>
      </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      // ---------- Trip radio: hide returning if one-way ----------
      (function () {
        const radios = document.querySelectorAll('input[name="trip"]');
        const returning = document.getElementById("returning");
        radios.forEach((r) => {
          r.addEventListener("change", () => {
            if (r.value === "oneway" && r.checked) {
              returning.style.display = "none";
            } else {
              returning.style.display = "block";
            }
          });
        });
        // initialize
        if (
          document.querySelector('input[name="trip"]:checked').value ===
          "oneway"
        ) {
          returning.style.display = "none";
        }
      })();

      // ---------- Passenger dropdown logic (syncs to number input #passengers) ----------
      (function () {
        const passengersInput = document.getElementById("passengers"); // original input (kept)
        const dropdown = document.getElementById("passenger-dropdown");
        const field = passengersInput.parentElement;
        const rows = dropdown.querySelectorAll(".passenger-row");
        // maintain counts
        let counts = { Adult: 1, Child: 0, Infant: 0 };

        function updatePassengersNumber() {
          const total = counts.Adult + counts.Child + counts.Infant;
          passengersInput.value = total;
        }

        // open dropdown when clicking the number input
        passengersInput.addEventListener("focus", (e) => {
          e.stopPropagation();
          dropdown.style.display = "block";
        });
        passengersInput.addEventListener("click", (e) => {
          e.stopPropagation();
          dropdown.style.display =
            dropdown.style.display === "block" ? "none" : "block";
        });

        // handlers for each row plus/minus
        rows.forEach((row) => {
          const type = row.dataset.type;
          const minus = row.querySelector(".minus");
          const plus = row.querySelector(".plus");
          const countSpan = row.querySelector(".count");

          minus.addEventListener("click", (ev) => {
            ev.stopPropagation();
            if (counts[type] > 0) {
              counts[type]--;
              countSpan.textContent = counts[type];
              updatePassengersNumber();
            }
          });
          plus.addEventListener("click", (ev) => {
            ev.stopPropagation();
            const total = counts.Adult + counts.Child + counts.Infant;
            if (total < 9) {
              // limit total passengers
              counts[type]++;
              countSpan.textContent = counts[type];
              updatePassengersNumber();
            }
          });
        });

        // Done button closes
        document
          .getElementById("done-passengers")
          .addEventListener("click", (e) => {
            dropdown.style.display = "none";
          });

        // click outside closes dropdown
        document.addEventListener("click", () => {
          dropdown.style.display = "none";
        });

        // ensure internal clicks don't close
        dropdown.addEventListener("click", (e) => {
          e.stopPropagation();
        });

        // init values
        rows.forEach((r) => {
          const t = r.dataset.type;
          r.querySelector(".count").textContent = counts[t];
        });
        updatePassengersNumber();
      })();

      // Keep departure_date synced with the visual departing_small if you like:
      (function () {
        const depMain = document.getElementById("departure_date");
        const depSmall = document.getElementById("departing_small");
        // when either changes, copy to the other if empty for UX
        depSmall.addEventListener("change", () => {
          if (!depMain.value) depMain.value = depSmall.value;
        });
        depMain.addEventListener("change", () => {
          if (!depSmall.value) depSmall.value = depMain.value;
        });
      })();
    </script>
  </body>
</html>
