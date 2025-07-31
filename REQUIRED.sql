CREATE TABLE IF NOT EXISTS `graft_users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `unique_id` VARCHAR(255) NOT NULL,
    `rank` ENUM("user", "trusted", "support", "moderator", "admin", "developer", "owner") NOT NULL DEFAULT "user",
    `username` VARCHAR(32) UNIQUE DEFAULT NULL,
    `vip` BOOLEAN NOT NULL DEFAULT 0,
    `priority` INT(11) NOT NULL DEFAULT 0,
    `characters` INT(11) NOT NULL DEFAULT 2,
    `license` VARCHAR(255) NOT NULL,
    `discord` VARCHAR(255),
    `tokens` JSON NOT NULL,
    `ip` VARCHAR(255) NOT NULL,
    `banned` BOOLEAN NOT NULL DEFAULT FALSE,
    `muted` TINYINT(1) NOT NULL DEFAULT 0,
    `deleted` TINYINT(1) NOT NULL DEFAULT 0,
    `notes` TEXT,
    `settings` JSON NOT NULL DEFAULT (JSON_OBJECT()),
    `last_login` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`unique_id`),
    UNIQUE KEY `username_unique` (`username`),
    KEY `license_idx` (`license`),
    KEY `id_idx` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `graft_bans` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `unique_id` VARCHAR(255) NOT NULL,
    `banned_by` VARCHAR(255) NOT NULL DEFAULT "graft",
    `reason` TEXT DEFAULT NULL,
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `expires_at` TIMESTAMP NULL DEFAULT NULL,
    `expired` TINYINT(1) NOT NULL DEFAULT 0,
    `appealed` TINYINT(1) NOT NULL DEFAULT 0,
    `appealed_by` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`unique_id`) REFERENCES `graft_users` (`unique_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `graft_licences` (
    `identifier` VARCHAR(255) NOT NULL,
    `licence_id` VARCHAR(50) NOT NULL,
    `category` VARCHAR(50) NOT NULL,
    `theory` TINYINT(1) NOT NULL DEFAULT 0,
    `practical` TINYINT(1) NOT NULL DEFAULT 0,
    `theory_date` DATETIME NULL,
    `practical_date` DATETIME NULL,
    `points` INT UNSIGNED NOT NULL DEFAULT 0,
    `max_points` INT UNSIGNED NOT NULL DEFAULT 12,
    `revoked` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`identifier`, `licence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `graft_xp` (
    `identifier` VARCHAR(255) NOT NULL,
    `xp_id` VARCHAR(50) NOT NULL,
    `type` ENUM("work", "skill", "reputation") NOT NULL,
    `category` VARCHAR(50) NOT NULL,
    `level` INT UNSIGNED NOT NULL DEFAULT 1,
    `xp` INT UNSIGNED NOT NULL DEFAULT 0,
    `xp_required` INT UNSIGNED NOT NULL DEFAULT 1000,
    `growth_factor` DECIMAL(4,2) NOT NULL DEFAULT 1.5,
    `max_level` INT UNSIGNED DEFAULT 20,
    `decay_rate` INT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (`identifier`, `xp_id`, `type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
