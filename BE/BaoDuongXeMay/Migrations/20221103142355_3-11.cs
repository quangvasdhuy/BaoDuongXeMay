using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class _311 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<float>(
                name: "KM_Old",
                table: "DetailVehicle_User",
                type: "real",
                nullable: false,
                defaultValue: 0f);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "KM_Old",
                table: "DetailVehicle_User");
        }
    }
}
