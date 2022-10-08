using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class addcategoryvehicles : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Vehicle_Accessarys_AccessaryID",
                table: "Vehicle");

            migrationBuilder.DropTable(
                name: "Accessarys");

            migrationBuilder.DropIndex(
                name: "IX_Vehicle_AccessaryID",
                table: "Vehicle");

            migrationBuilder.DropColumn(
                name: "AccessaryID",
                table: "Vehicle");

            migrationBuilder.AddColumn<Guid>(
                name: "CategoryVehicleID",
                table: "Vehicle",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "CategoryVehicles",
                columns: table => new
                {
                    CategoryVehicleID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CategoryVehicleName = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CategoryVehicles", x => x.CategoryVehicleID);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Vehicle_CategoryVehicleID",
                table: "Vehicle",
                column: "CategoryVehicleID");

            migrationBuilder.AddForeignKey(
                name: "FK_Vehicle_CategoryVehicles_CategoryVehicleID",
                table: "Vehicle",
                column: "CategoryVehicleID",
                principalTable: "CategoryVehicles",
                principalColumn: "CategoryVehicleID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Vehicle_CategoryVehicles_CategoryVehicleID",
                table: "Vehicle");

            migrationBuilder.DropTable(
                name: "CategoryVehicles");

            migrationBuilder.DropIndex(
                name: "IX_Vehicle_CategoryVehicleID",
                table: "Vehicle");

            migrationBuilder.DropColumn(
                name: "CategoryVehicleID",
                table: "Vehicle");

            migrationBuilder.AddColumn<int>(
                name: "AccessaryID",
                table: "Vehicle",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Accessarys",
                columns: table => new
                {
                    AccessaryID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AccessaryName = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Accessarys", x => x.AccessaryID);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Vehicle_AccessaryID",
                table: "Vehicle",
                column: "AccessaryID");

            migrationBuilder.AddForeignKey(
                name: "FK_Vehicle_Accessarys_AccessaryID",
                table: "Vehicle",
                column: "AccessaryID",
                principalTable: "Accessarys",
                principalColumn: "AccessaryID",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
