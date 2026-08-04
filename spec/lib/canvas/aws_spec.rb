# frozen_string_literal: true

#
# Copyright (C) 2026 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

describe Canvas::AWS do
  describe ".validate_v2_s3_config" do
    it "enables path-style addressing for S3-compatible endpoints" do
      config = {
        endpoint: "http://canvas-s3.inst.test:9000",
        region: "us-east-1"
      }

      validated_config = described_class.validate_v2_s3_config(config, "amazon_s3.yml")

      expect(validated_config).to include(config)
      expect(validated_config[:force_path_style]).to be true
    end

    it "does not override an explicit path-style setting" do
      config = {
        endpoint: "http://canvas-s3.inst.test:9000",
        force_path_style: false,
        region: "us-east-1"
      }

      validated_config = described_class.validate_v2_s3_config(config, "amazon_s3.yml")

      expect(validated_config[:force_path_style]).to be false
    end

    it "does not enable path-style addressing for default AWS S3 config" do
      config = {
        region: "us-east-1"
      }

      validated_config = described_class.validate_v2_s3_config(config, "amazon_s3.yml")

      expect(validated_config).not_to include(:force_path_style)
    end
  end
end
